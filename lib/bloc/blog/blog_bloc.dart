import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sessions/models/blogpost.model.dart';
import 'package:sessions/repositories/blog_repository.dart';
import 'package:sessions/utils/classes.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogPostRepository _blogRepository;

  BlogBloc(this._blogRepository) : super(BlogLoadingState()) {
    on<LoadBlogEvent>((event, emit) async {
      emit(BlogLoadingState());
      try {
        final blogs = await _blogRepository.getAllBlogs();
        print("loaded");
        emit(BlogLoadedState(blogs: blogs));
      } catch (error) {
        print(error);
        emit(BlogErrorState(error: error.toString()));
      }
    });
  }
}
