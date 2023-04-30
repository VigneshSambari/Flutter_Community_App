// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sessions/bloc/blog/blog_bloc_imports.dart';
import 'package:sessions/bloc/user/user_bloc.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/popup_menus.dart';
import 'package:sessions/components/snackbar.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/models/blogpost.model.dart';
import 'package:sessions/models/profile.model.dart';
import 'package:sessions/repositories/blog_repository.dart';
import 'package:sessions/repositories/profile_repository.dart';
import 'package:sessions/screens/blogScreens/components/blog_utils.dart';
import 'package:sessions/screens/blogScreens/createblog_screen.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/navigations.dart';

List<PairPopMenu> popUpOptions = [
  PairPopMenu(value: 0, option: "Create Blog"),
  PairPopMenu(value: 1, option: "College Blogs"),
  PairPopMenu(value: 2, option: "Public Blogs"),
  PairPopMenu(value: 3, option: "Your Blogs"),
  PairPopMenu(value: 4, option: "Friends Blogs"),
];

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  int pageCounter = 1;
  List<BlogPostModel> blogList = [];
  List<String> blogUserIds = [];
  int blogCount = 0;
  int limit = 20;
  String? userId;
  bool endReached = false;
  bool _isDisposed = false;
  bool _isLoading = false, sendLoading = false;
  late ScrollController _scrollController;
  String? errorString;
  Map<String, ProfileModel> mapIdProfile = {};
  final BlogPostRepository _blogPostRepository = BlogPostRepository();
  final ProfileRepository _profileRepository = ProfileRepository();

  @override
  void initState() {
    final UserState userState = BlocProvider.of<UserBloc>(context).state;
    if (userState is UserSignedInState) {
      userId = userState.user.userId!;
    }
    fetchData();

    _scrollController = ScrollController();

    super.initState();
  }

  Future<void> fetchData() async {
    if (_isDisposed || !mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      // print("on");
      endReached = true;
    });
    try {
      final List<BlogPostModel> blogsNew =
          await _blogPostRepository.getPagedBlogs(
              httpData:
                  FetchPagedBlogs(limit: limit - blogCount, page: pageCounter));
      blogCount += blogsNew.length;
      for (BlogPostModel blog in blogsNew) {
        blogUserIds.add(blog.postedBy!);
        String id = blog.postedBy!;
        final ProfileModel? profile =
            await _profileRepository.loadProfile(userId: id);
        if (!mapIdProfile.containsKey(id)) {
          mapIdProfile[id] = profile!;
        }
        blogList.add(blog);
      }
    } catch (error) {
      showMySnackBar(context, error.toString());
    }
    if (blogCount == limit) {
      pageCounter++;
      blogCount = 0;
      blogUserIds = [];
    }
    if (_isDisposed || !mounted) {
      return;
    }

    if (blogCount != 0) {
      endReached = false;
    } else {
      endReached = true;
    }

    setState(() {
      _isLoading = false;
      // print("off");
      blogList;
      errorString;
      blogUserIds;
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _scrollController.dispose();
    super.dispose();
  }

  void popUpMenuFun({required int value}) {
    if (value == 0) {
      navigatorPush(CreateBlog(callback: () {
        fetchData();
      }), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RepositoryProvider(
      create: (context) => BlogPostRepository(),
      child: BlocProvider(
        create: (context) => BlogBloc(
          RepositoryProvider.of<BlogPostRepository>(context),
        )..add(LoadBlogEvent()),
        child: Scaffold(
          appBar: CurvedAppBar(
            title: "Blogs",
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: GestureDetector(
                  child: Icon(Icons.search),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: PopUpMenuWidget(
                  options: popUpOptions,
                  onSelect: popUpMenuFun,
                ),
              ),
            ],
            leading: SizedBox(),
          ),
          body: Container(
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.all(2),
            child: NotificationListener(
              onNotification: (ScrollNotification scrollInfo) {
                if (!_isLoading &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  fetchData();
                }
                return true;
              },
              child: _isLoading && blogList.isEmpty
                  ? LoadingIndicator()
                  : RefreshIndicator(
                      onRefresh: () async {
                        Duration(seconds: 2);

                        await fetchData();
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        itemCount: blogList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BlogTile(
                            blog: blogList[index],
                            user: mapIdProfile[blogList[index].postedBy]!,
                          );
                        },
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
