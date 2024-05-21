import 'package:tdd_example/core/repositories/posts_repository/base_post_repository.dart';
import 'package:tdd_example/core/services/http_service.dart';
import 'package:tdd_example/models/post_model/post_model.dart';

class RealPostsRepository implements PostsRepository {
  RealPostsRepository({required this.httpService}) {
    _loadData();
  }

  @override
  final BaseHttpService httpService;
  final _endpoint = '/posts';

  // Mock data storage for the products
  final List<PostModel> _posts = [];

  Future<void> _loadData() async {
    try {
      final data = await httpService.get(_endpoint);
      // Since the data returned by the api is a Map
      if (data['posts'] is List) {
        final posts = data['posts'] as List;
        _posts.addAll(posts
            .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
            .toList());
        // Now s`list` contains the list of PostModel
      } else {
        throw Exception("Could not fetch data");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PostModel>> getPosts() async {
    await _loadData();
    return _posts;
  }

  @override
  Future<PostModel> createPost(PostModel product) async {
    // Simulating network delay
    await Future.delayed(const Duration(seconds: 1));
    _posts.add(product);
    return product;
  }

  @override
  Future<PostModel> updatePost(PostModel product) async {
    // Simulating network delay
    await Future.delayed(const Duration(seconds: 1));
    final index = _posts.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _posts[index] = product;
      return product;
    } else {
      throw Exception("Post not found");
    }
  }

  @override
  Future<bool> deletePost(String id) async {
    // Simulating network delay
    await Future.delayed(const Duration(seconds: 1));
    final index = _posts.indexWhere((p) => p.id.toString() == id);
    if (index != -1) {
      _posts.removeAt(index);
      return true;
    } else {
      throw Exception("Post not found");
    }
  }
}
