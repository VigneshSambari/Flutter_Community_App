// ignore_for_file: prefer_const_constructors_in_immutables

part of 'blog_bloc.dart';

@immutable
abstract class BlogEvent extends Equatable {
  const BlogEvent();
}

class LoadBlogEvent extends BlogEvent {
  @override
  List<Object?> get props => [];
}

class CreateBlogEvent extends BlogEvent {
  final CreateBlogSend blogData;

  CreateBlogEvent({required this.blogData});

  @override
  List<Object?> get props => [];
}
