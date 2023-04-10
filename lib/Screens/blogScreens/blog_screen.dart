// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable

import 'package:flutter/material.dart';
import 'package:sessions/bloc/blog/blog_bloc_imports.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/repositories/blog_repository.dart';
import 'package:sessions/screens/blogScreens/components/blog_utils.dart';

List<Widget> widgets = [
  BlogTile(),
  BlogTile(),
  BlogTile(),
  BlogTile(),
  BlogTile(),
  BlogTile(),
  BlogTile(),
  BlogTile(),
  BlogTile()
];

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

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
            actions: [],
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
                          itemCount: widgets.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index != widgets.length) {
                              return BlogTile();
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
