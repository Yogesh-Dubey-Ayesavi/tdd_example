import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_example/features/home/widgets/post_card_widget.dart';
import 'package:tdd_example/models/post_model/post_model.dart';

void main() {
  const post = PostModel(
    title: 'Test Post',
    body: 'This is a test post',
    tags: ['flutter', 'testing'],
    reactions: 5,
    userId: 32,
    id: 1,
  );

  testWidgets('PostCard displays post details', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: PostCard(
              post: post,
              onReact: (reacted) {
                // ignore
              },
              onDelete: () {},
            ),
          ),
        ),
      ),
    );

    expect(find.text('Test Post'), findsOneWidget);
    expect(find.text('This is a test post'), findsOneWidget);
    expect(find.text('flutter'), findsOneWidget);
    expect(find.text('testing'), findsOneWidget);
    expect(find.text('Reactions: 5'), findsOneWidget);
  });

  testWidgets('PostCard like button toggles like state',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: PostCard(
              post: post,
              onReact: (reacted) {
                // ignore
              },
              onDelete: () {},
            ),
          ),
        ),
      ),
    );

    final likeButton = find.byKey(const Key('likeButton'));

    expect(likeButton, findsOneWidget);
    expect(find.text('Test Post'), findsOneWidget);
    await tester.tap(likeButton);
    await tester.pump();
    expect(find.text('Reactions: 6'), findsOneWidget);
  });

  testWidgets('PostCard delete button calls deletePost',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: PostCard(
              post: post,
              onReact: (reacted) {
                // ignore
              },
              onDelete: () {},
            ),
          ),
        ),
      ),
    );

    final deleteButton = find.byKey(const Key('deleteButton'));
    expect(deleteButton, findsOneWidget);
    await tester.tap(deleteButton);
  });
}
