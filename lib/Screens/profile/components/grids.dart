// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sessions/assets.dart';
import 'package:sessions/bloc/blog/blog_bloc_imports.dart';
import 'package:sessions/bloc/profile/profile_bloc.dart';
import 'package:sessions/components/snackbar.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/models/blogpost.model.dart';
import 'package:sessions/models/profile.model.dart';
import 'package:sessions/repositories/blog_repository.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/util_methods.dart';

class GridBlogs extends StatefulWidget {
  GridBlogs({Key? key}) : super(key: key);

  @override
  State<GridBlogs> createState() => _GridBlogsState();
}

class _GridBlogsState extends State<GridBlogs> {
  List<BlogPostModel> blogs = [];
  bool isLoading = false, isDisposed = false;
  BlogPostRepository blogPostRepository = BlogPostRepository();
  late ProfileModel profile;

  @override
  void initState() {
    setProfile();
    super.initState();
  }

  void setProfile() {
    ProfileState profileState = BlocProvider.of<ProfileBloc>(context).state;
    if (profileState is ProfileCreatedState) {
      profile = profileState.profile;
    }
    fetchBlogs(ids: IdList(ids: profile.blogs ?? []));
  }

  Future<void> fetchBlogs({required IdList ids}) async {
    setState(() {
      isLoading = true;
    });
    try {
      blogs = await blogPostRepository.getListedRooms(ids: ids);
    } catch (error) {
      showMySnackBar(context, error.toString());
    }

    if (isDisposed || !mounted) {
      return;
    }
    setState(() {
      isLoading = false;
      blogs;
    });
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 3;
    // Calculate the width of each grid cell dynamically based on the number of images that can fit in a row.

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        setProfile();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7),
        child: isLoading
            ? LoadingIndicator(
                circularBlue: true,
              )
            : GridView.builder(
                shrinkWrap: true,
                itemCount: blogs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  String url = "";
                  if (blogs[index].coverMedia != null) {
                    for (CoverMediaItem item in blogs[index].coverMedia!) {
                      if (item.secureUrl != null &&
                          getFileType(item.secureUrl!) == "image") {
                        url = item.secureUrl!;
                        break;
                      }
                    }
                  }
                  if (index != blogs.length) {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                      ),
                      child: url == ""
                          ? Image.asset(
                              Assets.assetsGlobalNoimageexists,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: url,
                              fit: BoxFit.cover,
                            ),
                    );
                  } else {
                    return SizedBox(
                      height: 100,
                    );
                  }
                },
              ),
      ),
    );
  }
}
