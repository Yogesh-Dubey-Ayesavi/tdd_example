import 'package:tdd_example/models/post_model/post_model.dart';

abstract class BasePostsRepository {
  const BasePostsRepository();

  /// Fetches a list of products.
  ///
  /// Returns a list of products on success.
  Future<List<PostModel>> getPosts();

  /// Creates a new product.
  ///
  /// [product]: The product to be created.
  ///
  /// Returns the created product.
  Future<PostModel> createPost(PostModel product);

  /// Updates an existing product.
  ///
  /// [product]: The product to be updated.
  ///
  /// Returns the updated product.
  Future<PostModel> updatePost(PostModel product);

  /// Deletes a product by its [id].
  ///
  /// [id]: The ID of the product to be deleted.
  ///
  /// Returns a boolean indicating success.
  Future<bool> deletePost(String id);
}
