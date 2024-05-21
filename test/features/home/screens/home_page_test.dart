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
  late PostsRepository realPostsRepository;
  setUp(() {
    mockController = MockHomePageController();
    realPostsRepository = MockPostRepository();
  });

  tearDown(() {
    // container.dispose();
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        postsRepositoryProvider.overrideWith((ref) => realPostsRepository),
        homePageControllerProvider.overrideWith(() {
          return mockController;
        }),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }

  testWidgets('displays loading indicator when state is loading',
      (WidgetTester tester) async {
    when(() => mockController.state)
        .thenReturn(const HomePageControllerState.loading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

//   testWidgets('displays list of posts when state is data', (WidgetTester tester) async {
//     final posts = [
//       Post(id: '1', content: 'Post 1'),
//       Post(id: '2', content: 'Post 2'),
//     ];
//     when(() => mockController.state).thenReturn(AsyncValue.data(posts));

//     await tester.pumpWidget(createWidgetUnderTest());

//     expect(find.byType(ListView), findsOneWidget);
//     expect(find.byType(PostCard), findsNWidgets(posts.length));
//   });

//   testWidgets('displays error message when state is error', (WidgetTester tester) async {
//     when(() => mockController.state).thenReturn(const AsyncValue.error('Error message'));

//     await tester.pumpWidget(createWidgetUnderTest());

//     expect(find.text('Error'), findsOneWidget);
//   });

//   testWidgets('displays network error message when state is networkError', (WidgetTester tester) async {
//     when(() => mockController.state).thenReturn(const AsyncValue.networkError());

//     await tester.pumpWidget(createWidgetUnderTest());

//     expect(find.text('Oops! Looks like you are not connected to the internet'), findsOneWidget);
//   });

//   testWidgets('deletes a post when delete button is tapped', (WidgetTester tester) async {
//     final posts = [
//       Post(id: '1', content: 'Post 1'),
//       Post(id: '2', content: 'Post 2'),
//     ];
//     when(() => mockController.state).thenReturn(AsyncValue.data(posts));
//     when(() => mockController.deletePost(any())).thenAnswer((_) async {});

//     await tester.pumpWidget(createWidgetUnderTest());

//     await tester.tap(find.byIcon(Icons.delete).first);
//     await tester.pumpAndSettle();

//     verify(() => mockController.deletePost(posts.first.id)).called(1);
//   });
}
