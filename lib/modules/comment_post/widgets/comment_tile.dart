import 'package:book_app/model/comment_model.dart';
import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({super.key, required this.commentModel});

  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage:
                  const NetworkImage('https://picsum.photos/250?image=9'),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        commentModel.autorName ?? 'Usuário',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '• há 2h', // Você pode adicionar timestamp ao model
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    commentModel.content,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _bottomCommentActions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomCommentActions() {
    return Row(
      children: [
        TextButton.icon(
          onPressed: () {
            // Implementar like
          },
          icon: Icon(
            Icons.thumb_up_outlined,
            size: 16,
            color: Colors.grey[600],
          ),
          label: Text(
            'Curtir',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        const SizedBox(width: 16),
        TextButton.icon(
          onPressed: () {
            // Implementar resposta
          },
          icon: Icon(
            Icons.reply,
            size: 16,
            color: Colors.grey[600],
          ),
          label: Text(
            'Responder',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }
}
