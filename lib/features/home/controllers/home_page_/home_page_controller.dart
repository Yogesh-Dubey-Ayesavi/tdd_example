import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tdd_example/core/repositories/posts_repository/base_post_repository.dart';
import 'package:tdd_example/core/repositories/posts_repository/post_repository_provider.dart';
import 'package:tdd_example/models/post_model/post_model.dart';

part 'home_page_controller.freezed.dart';
part 'home_page_controller.g.dart';
part 'home_page_controller_state.dart';

@riverpod
class HomePageController extends _$HomePageController {
  late PostsRepository _repository;

  List<PostModel> _posts = <PostModel>[];

  @override
  HomePageControllerState build() {
    _repository = ref.read(postsRepositoryProvider);
    getPosts();
    return const HomePageControllerState.loading();
  }

  getPosts() async {
    try {
      final posts = await _repository.getPosts();
      _posts = posts;
      state = HomePageControllerState.data(posts: _posts);
    } catch (e) {
      if (e is SocketException) {
        state = const HomePageControllerState.networkError();
      }
      state = HomePageControllerState.error(e);
    }
  }

  deletePost(int postId) async {
    _posts.removeWhere((e) => e.id == postId);
    state = HomePageControllerState.data(posts: _posts);
  }

  updatePostReactions(int postId, PostModel updatedPostModel) async {
    final index = _posts.indexWhere((e) => e.id == postId);
    _posts[index] = updatedPostModel;
  }
}
