import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_example/core/repositories/posts_repository/base_post_repository.dart';
import 'package:tdd_example/core/repositories/posts_repository/post_repository_provider.dart';
import 'package:tdd_example/core/repositories/posts_repository/real_posts_repository.dart';
import 'package:tdd_example/core/services/http_service.dart';
import 'package:tdd_example/features/home/controllers/home_page_/home_page_controller.dart';
import 'package:tdd_example/features/home/screens/home_page.dart';

class MockHttpService extends Mock implements DioHttpService {}

class MockPostRepository extends Mock implements RealPostsRepository {}

class MockHomePageController
    extends AutoDisposeNotifier<HomePageControllerState>
    with Mock
    implements HomePageController {}

void main() {
  late MockHomePageController mockController;
  late BasePostsRepository realBasePostsRepository;

  setUp(() {
    mockController = MockHomePageController();
    realBasePostsRepository = MockPostRepository();
  });

  tearDown(() {
    // container.dispose();
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        postsRepositoryProvider.overrideWith((ref) => realBasePostsRepository),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }

  testWidgets('displays loading indicator when state is loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
