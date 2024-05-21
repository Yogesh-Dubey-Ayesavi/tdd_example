import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_example/features/home/controllers/home_page_/home_page_controller.dart';
import 'package:tdd_example/features/home/widgets/post_card_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homePageControllerProvider);
    final controller = ref.read(homePageControllerProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Home Page Feed",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          // use from theme constants
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: state.when(
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            data: (posts) {
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return PostCard(
                    post: posts[index],
                    onReact: (reacted) {
                      // send this to database
                      /// user has been reacted
                    },
                    onDelete: () {
                      controller.deletePost(posts[index].id);
                    },
                  );
                },
              );
            },
            error: (e) {
              return Center(
                child: Text(
                  'Error',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              );
            },
            networkError: () {
              return Center(
                child: Text(
                  'Oops! Looks like you are not connected to the internet',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              );
            },
          ),
        ));
  }
}
