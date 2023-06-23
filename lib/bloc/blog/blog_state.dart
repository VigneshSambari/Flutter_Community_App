part of 'blog_bloc.dart';

@immutable
abstract class BlogState extends Equatable {}

//blog loading state
class BlogLoadingState extends BlogState {
  @override
  List<Object> get props => [];
}

//blog loaded state
class BlogLoadedState extends BlogState {
  final List<BlogPostModel> blogs;
  BlogLoadedState({required this.blogs});
  @override
  List<Object?> get props => [];
}

//blog error state
class BlogErrorState extends BlogState {
  final String error;
  BlogErrorState({required this.error});
  @override
  List<Object> get props => [];
}
