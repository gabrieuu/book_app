import 'package:book_app/model/book_model.dart';
import 'package:book_app/model/images.dart';
import 'package:book_app/model/postModel/post_model.dart';
import 'package:book_app/modules/books/store/book_store.dart';
import 'package:book_app/modules/books/widgets/book_postagem.dart';
import 'package:book_app/modules/posts/post_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EnhancedPostTile extends StatefulWidget {
  final PostModel post;

  const EnhancedPostTile({Key? key, required this.post}) : super(key: key);

  @override
  State<EnhancedPostTile> createState() => _EnhancedPostTileState();
}

class _EnhancedPostTileState extends State<EnhancedPostTile> {
  bool isLiked = false;
  bool isSaved = false;
  int likeCount = 0;
  int commentCount = 0;
  PostStore postStore = Modular.get();
  BookStore bookStore = Modular.get();
  Book? book;

  @override
  void initState() {
    super.initState();
    isLiked = widget.post.isCurtido;
    likeCount = widget.post.quantidadeCurtidas;
    commentCount = widget.post.quantidadeComentarios;
    _getImagesAndBook();
  }

  Future<void> _getImagesAndBook() async{
    if(widget.post.bookId != null){
      book = await bookStore.getBookById(widget.post.bookId!);
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostHeader(),
          _buildPostContent(),
          if (book != null) BookPostagem(bookData: book!, onTap: (){
            Modular.to.pushNamed('/initial/book/details', arguments: book);
          },),
          if (book != null) _buildPostImage(widget.post.images ?? <Images>[]),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildPostHeader() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Modular.to
                .pushNamed('/initial/profile', arguments: widget.post.autorId),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue[100],
              child: Icon(
                Icons.person,
                color: Colors.blue[600],
                size: 30,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.autorName ?? 'Usuário Desconhecido',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF1C1C1C),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '2 horas atrás',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showMoreOptions(),
            icon: Icon(
              Icons.more_vert,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        widget.post.content,
        style: const TextStyle(
          fontSize: 15,
          height: 1.4,
          color: Color(0xFF2C2C2C),
        ),
      ),
    );
  }

  Widget _buildPostImage(List<Images> imageUrl) {
    if(imageUrl.isEmpty){
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: double.infinity,
      height: 280,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(0),
        ),
        child: Image.network(
          imageUrl.first.url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 48,
                  color: Colors.grey,
                ),
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: Colors.grey[200],
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          _buildActionButton(
            icon: isLiked ? Icons.favorite : Icons.favorite_border,
            count: likeCount,
            label: 'Curtir',
            color: isLiked ? Colors.red : Colors.grey[600]!,
            onTap: _toggleLike,
          ),
          const SizedBox(width: 24),
          _buildActionButton(
            icon: Icons.comment_outlined,
            count: commentCount,
            label: 'Comentar',
            color: Colors.grey[600]!,
            onTap: () => _openComments(),
          ),          
          
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required int count,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 6),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBottomSheetOption(Icons.edit, 'Editar post'),
            _buildBottomSheetOption(Icons.delete, 'Excluir post'),
            _buildBottomSheetOption(Icons.report, 'Denunciar'),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      onTap: () => Navigator.pop(context),
    );
  }

  void _toggleLike() {
    postStore.curtirPost(widget.post);
    isLiked = !isLiked;
    likeCount = isLiked ? likeCount + 1 : likeCount - 1;
    setState(() {});
  }

  void _openComments() {
    Modular.to.pushNamed('/initial/comment/', arguments: widget.post);
  }

  void _sharePost() {
    // Implement share functionality
    print('Sharing post');
  }
}
