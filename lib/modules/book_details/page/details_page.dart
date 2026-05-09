import 'dart:ui';

import 'package:book_app/core/status.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/modules/book_details/details_controller.dart';
import 'package:book_app/modules/book_details/widget/author_tile_widget.dart';
import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({super.key, required this.book});

  final BookModel book;
  static String route = '/details';
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  DetailsController detailsController = Modular.get();
  bool isFavorita = false;
  FavoritasStore favoritasStore = Modular.get();
  bool expandableText = false;
  late final PageController _coverCarouselController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _coverCarouselController = PageController(viewportFraction: 0.72);
    _initAnimations();
    _loadBookDetails();
  }

  Future<void> _loadBookDetails() async {
    await detailsController.loadBookDetails(widget.book.apiId);
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _coverCarouselController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Observer(builder: (_) {
                  if (detailsController.status == Status.CARREGANDO) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (detailsController.status == Status.SUCESSO) {
                  return Column(
                    children: [
                      _buildBookInfo(),
                      _buildActionButtons(),
                      _buildBookStats(),
                      // _buildQuickInfo(),
                      _buildDescription(),
                      _buildBookDetails(),
                      _buildAuthorTile(),
                      const SizedBox(height: 100),
                    ],
                  );
                  }
                  return const SizedBox();
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return Observer(builder: (_) {
      final status = detailsController.status;

      return SliverAppBar(
        expandedHeight: 400,
        floating: false,
        pinned: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: _buildBackButton(),
        actions: _buildActions(),
        flexibleSpace: FlexibleSpaceBar(
          background: _buildAppBarContent(status),
        ),
      );
    });
  }

  Widget _buildAppBarContent(Status status) {
    if (status == Status.CARREGANDO || status == Status.NAO_CARREGADO) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status == Status.ERRO) {
      return const Center(child: Text('Erro ao carregar'));
    }

    final book = detailsController.book;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                book.coversUrls.isNotEmpty
                    ? book.coversUrls.first
                    : 'https://via.placeholder.com/300x400',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 80),
            child: _buildCoverCarousel(book),
          ),
        ),
      ],
    );
  }

  Widget _buildCoverCarousel(dynamic book) {
    final coverUrls = book.coversUrls.isNotEmpty
        ? book.coversUrls
        : ['https://via.placeholder.com/300x400'];

    return SizedBox(
      height: 270,
      child: PageView.builder(
        controller: _coverCarouselController,
        itemCount: coverUrls.length,
        itemBuilder: (context, index) {
          final coverUrl = coverUrls[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Hero(
                tag: 'book_${book.hashCode}_$index',
                child: Container(
                  width: 180,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(coverUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
      ),
    );
  }

  List<Widget> _buildActions() {
    return [
      Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Observer(
          builder: (_) => IconButton(
            onPressed: () {
              // if (isFavorita) {
              //   favoritasStore.removeFavorita(detailsController.book!);
              // } else {
              //   favoritasStore.addFavorite(book: detailsController.book!);
              // }
              // setState(() {
              //   isFavorita = favoritasStore.isFavorita(detailsController.book!);
              // });
            },
            icon: Icon(
              isFavorita ? Icons.favorite : Icons.favorite_border,
              color: isFavorita ? Colors.red[400] : Colors.black87,
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.share, color: Colors.black87),
        ),
      ),
    ];
  }

  Widget _buildBookInfo() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Rating
          if (detailsController.book.averageRating != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBarIndicator(
                  rating:
                      detailsController.book.averageRating?.toDouble() ?? 0.0,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
                const SizedBox(width: 8),
                Text(
                  '(${detailsController.book.averageRating ?? 0})',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          // Title
          Text(
            detailsController.book.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Authors
          Text(
            widget.book.author,
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue[600],
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          // Publisher
          if (detailsController.book.publisher != null)
            Text(
              detailsController.book.publisher!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chrome_reader_mode, size: 20),
                  SizedBox(width: 8),
                  Text('Ler Agora',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(color: Colors.blue[600]!),
              ),
              child: Icon(Icons.bookmark_add, color: Colors.blue[600]),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(color: Colors.blue[600]!),
              ),
              child: Icon(Icons.download, color: Colors.blue[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookStats() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            Icons.calendar_today,
            detailsController.book.publisheDate.split('-')[0],
            'Ano',
            Colors.blue[600]!,
          ),
          _buildVerticalDivider(),
          // _buildStatItem(
          //   Icons.book,
          //   '${detailsController.book!.volumeInfo.pageCount ?? 0}',
          //   'Páginas',
          //   Colors.green[600]!,
          // ),
          _buildVerticalDivider(),
          _buildStatItem(
            Icons.language,
            // detailsController.book!.volumeInfo.language?.toUpperCase() ??
            'N/A',
            'Idioma',
            Colors.orange[600]!,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
      IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[200],
    );
  }

  // Widget _buildQuickInfo() {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 24),
  //     child: Row(
  //       children: [
  //         if (detailsController.book!.volumeInfo.categories != null &&
  //             detailsController.book!.volumeInfo.categories!.isNotEmpty)
  //           Expanded(
  //             child: Wrap(
  //               spacing: 8,
  //               runSpacing: 8,
  //               children:
  //                   detailsController.book!.volumeInfo.categories!.take(3).map((category) {
  //                 return Container(
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //                   decoration: BoxDecoration(
  //                     color: Colors.blue[50],
  //                     borderRadius: BorderRadius.circular(20),
  //                     border: Border.all(color: Colors.blue[200]!),
  //                   ),
  //                   child: Text(
  //                     category,
  //                     style: TextStyle(
  //                       color: Colors.blue[700],
  //                       fontSize: 12,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 );
  //               }).toList(),
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildDescription() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.description, color: Colors.blue[600], size: 24),
              const SizedBox(width: 12),
              const Text(
                'Sobre o Livro',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              setState(() {
                expandableText = !expandableText;
              });
            },
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: expandableText ? null : 120,
                  child: Html(
                    data: detailsController.book.description,
                    style: {
                      "body": Style(
                        fontSize: FontSize(15),
                        color: Colors.grey[700],
                        lineHeight: LineHeight(1.6),
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                      ),
                      "p": Style(
                        fontSize: FontSize(15),
                        color: Colors.grey[700],
                        margin: Margins.only(bottom: 12),
                      ),
                      "b": Style(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2D3748),
                      ),
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      expandableText ? 'Ver menos' : 'Ver mais',
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      expandableText
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.blue[600],
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookDetails() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[600], size: 24),
              const SizedBox(width: 12),
              const Text(
                'Detalhes do Livro',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // _buildDetailRow(
          //     'ISBN',
          //     detailsController.book!.volumeInfo.isbn?.isNotEmpty == true
          //         ? detailsController.book!.volumeInfo.isbn
          //         : 'N/A'),
          _buildDetailRow(
              'Editora', detailsController.book.publisher ?? 'N/A'),
          _buildDetailRow(
              'Data de Publicação', detailsController.book.publisheDate),
          // _buildDetailRow('Idioma',
          //     detailsController.book!.language?.toUpperCase() ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(
                color: Color(0xFF2D3748),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorTile() {
    if (detailsController.book.authorId == null ||
        detailsController.book.authorId!.isEmpty) {
      return const SizedBox.shrink();
    }

    return AuthorTileWidget(
      authorId: detailsController.book.authorId!,
    );
  }
}
