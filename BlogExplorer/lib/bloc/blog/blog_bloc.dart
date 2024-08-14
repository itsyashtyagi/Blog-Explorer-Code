import 'package:blog_explorer/bloc/blogs/blog_event.dart';
import 'package:blog_explorer/bloc/blogs/blog_state.dart';
import 'package:blog_explorer/repository/blog_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogListRepository repository = BlogListRepository();
  BlogBloc() : super(const BlogState()) {
    on<BlogFetched>(fetchBlogApi);
  }

  void fetchBlogApi(BlogFetched event, Emitter<BlogState> emit) async {
    await repository.fetchBlogListData().then((value) {
      emit(state.copyWith(
        blogList: value.blogs,
        blogStatus: BlogStatus.success,
        message: "success",
      ));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          blogList: [],
          blogStatus: BlogStatus.failure,
          message: error.toString()));
    });
  }
}
