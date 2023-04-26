// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable

import 'package:flutter/material.dart';
import 'package:sessions/bloc/blog/blog_bloc_imports.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/popup_menus.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/repositories/blog_repository.dart';
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
  void popUpMenuFun({required int value}) {
    if (value == 0) {
      navigatorPush(CreateBlog(), context);
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
                child: PopUpMenuWidget(
                  options: popUpOptions,
                  onSelect: popUpMenuFun,
                ),
              ),
            ],
            leading: SizedBox(),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  width: size.width,
                  height: size.height,
                  padding: EdgeInsets.all(2),
                  child: BlocBuilder<BlogBloc, BlogState>(
                    builder: (context, state) {
                      if (state is BlogLoadingState) {
                        return LoadingIndicator();
                        //return Center(child: CircularProgressIndicator());
                      }
                      if (state is BlogLoadedState) {
                        //return LoadingIndicator();
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: state.blogs.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index != state.blogs.length) {
                              return BlogTile(
                                blog: state.blogs[index],
                              );
                            } else {
                              return SizedBox(
                                height: 100,
                              );
                            }
                          },
                        );
                      }
                      if (state is BlogErrorState) {
                        return Center(
                            child: Text(
                          "Error",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ));
                      }
                      return Center(
                        child: Text("Default"),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
