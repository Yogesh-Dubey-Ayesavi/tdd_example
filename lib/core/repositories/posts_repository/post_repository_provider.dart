import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tdd_example/core/repositories/posts_repository/base_post_repository.dart';
import 'package:tdd_example/core/repositories/posts_repository/real_posts_repository.dart';
import 'package:tdd_example/core/services/http_service.dart';

part 'post_repository_provider.g.dart';

@riverpod
PostsRepository postsRepository(PostsRepositoryRef ref) {
  return RealPostsRepository(httpService: DioHttpService());
}
