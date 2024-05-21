import 'package:flutter/material.dart';
import 'package:tdd_example/models/post_model/post_model.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final void Function(bool) onReact;
  final VoidCallback onDelete;

  const PostCard({
    super.key,
    required this.post,
    required this.onReact,
    required this.onDelete,
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    widget.onReact(isLiked);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final post = widget.post;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  post.body,
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 8.0),
                Wrap(
                  spacing: 8.0,
                  children:
                      post.tags.map((tag) => Chip(label: Text(tag))).toList(),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Reactions: ${isLiked ? post.reactions + 1 : post.reactions}',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: -12,
              child: Row(
                children: [
                  IconButton(
                    key: const Key('likeButton'),
                    icon: Icon(
                      Icons.thumb_up,
                      color: isLiked ? Colors.blue : null,
                    ),
                    onPressed: toggleLike,
                  ),
                  Text('${isLiked ? post.reactions + 1 : post.reactions}'),
                  IconButton(
                    key: const Key('deleteButton'),
                    color: Theme.of(context).colorScheme.error,
                    icon: const Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
