import 'package:blog_explorer/model/blog_data.dart';
import 'package:equatable/equatable.dart';

enum BlogStatus { initial, success, failure }

class BlogState extends Equatable {
  final BlogStatus blogStatus;
  final List<Blogs> blogList;
  final String message;

  const BlogState({
    this.blogStatus = BlogStatus.initial,
    this.blogList = const <Blogs>[],
    this.message = '',
  });

  BlogState copyWith({
    BlogStatus? blogStatus,
    List<Blogs>? blogList,
    String? message,
  }) {
    return BlogState(
      blogStatus: blogStatus ?? this.blogStatus,
      blogList: blogList ?? this.blogList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [];
}
