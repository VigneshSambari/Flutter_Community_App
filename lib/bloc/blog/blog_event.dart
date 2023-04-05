part of 'blog_bloc.dart';

@immutable
abstract class BlogEvent extends Equatable {
  const BlogEvent();
}

class LoadBlogEvent extends BlogEvent {
  @override
  List<Object?> get props => [];
}
