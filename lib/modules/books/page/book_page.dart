import 'package:book_app/model/book_model.dart';
import 'package:book_app/modules/books/store/book_store.dart';
import 'package:book_app/modules/books/widgets/book_widget.dart';
import 'package:book_app/modules/books/widgets/recomendados_shimmer.dart';
import 'package:book_app/modules/home/controller/bottom_navigator_controller.dart';
import 'package:book_app/shared/appbar.dart';
import 'package:book_app/shared/menu_drawer.dart';
import 'package:book_app/core/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:mobx/mobx.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});
  static String rota = '/book';
  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> with TickerProviderStateMixin {
  BookStore bookStore = Modular.get();
  BottomNavigatorController navigator = Modular.get();
  final debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  final FocusNode _focusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();

    bookStore.searchBook.addListener(() {
      if (bookStore.searchBook.text.isEmpty) {
        bookStore.listBooksSearches.clear();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void clear() {
    bookStore.searchBook.clear();
    bookStore.searchIsSelect = false;
    bookStore.listBooksSearches.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Observer(
        builder: (context) {
          return CustomScrollView(
            slivers: [
              _buildCustomAppBar(),
              if (bookStore.searchIsSelect &&
                  bookStore.listBooksSearches.isNotEmpty)
                _buildSearchResultsSliver()
              else ...[
                _buildHeroSection(),
                _buildFeaturedBooksSliver(),
                _buildCategoriesSliver(),
                _buildBooksGridSliver(),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return SliverAppBar(
      expandedHeight: 50,
      floating: true,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      forceMaterialTransparency: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Observer(
            builder: (context) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (bookStore.searchIsSelect)
                    IconButton(
                      onPressed: clear,
                      icon: const Icon(Icons.arrow_back, color: Colors.grey),
                    ),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: TextField(
                        controller: bookStore.searchBook,
                        focusNode: _focusNode,
                        onChanged: (string) async {
                          if (bookStore.searchBook.text.isEmpty) {
                            bookStore.listBooksSearches.clear();
                            setState(() {});
                          }
                          if (string.isNotEmpty) {
                            debouncer(() async {
                              await bookStore.searchBooks(string);
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Buscar livros, autores...',
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
                          prefixIcon:
                              Icon(Icons.search, color: Colors.grey[500]),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return SliverToBoxAdapter(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.purple[400]!,
                Colors.blue[500]!,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: 40,
                bottom: -30,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.auto_stories,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Livro do Dia',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Descubra nossa seleção especial',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Ver agora',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedBooksSliver() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Em Destaque',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward,
                      size: 16, color: Colors.blue[600]),
                  label: Text(
                    'Ver todos',
                    style: TextStyle(
                        color: Colors.blue[600], fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 280,
            child: Observer(
              builder: (_) {
                switch (bookStore.livrosRecomendadosStatus) {
                  case Status.CARREGANDO:
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: 5,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(right: 16),
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const RecomendadosShimmer(),
                      ),
                    );
                  case Status.SUCESSO:
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: bookStore.recomendados.length,
                      itemBuilder: (context, index) {
                        final book = bookStore.recomendados[index];
                        return _BookRecomendedTile(book: book);
                      },
                    );
                  default:
                    return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSliver() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Categorias',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: Observer(
              builder: (_) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: bookStore.listCategorias.length,
                  itemBuilder: (context, index) {
                    final isSelected =
                        bookStore.indexCategoriaSelecionada == index;
                    return Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        onTap: () {
                          bookStore.indexCategoriaSelecionada = index;
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 100,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue[600] : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue[600]!
                                  : Colors.grey[200]!,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? Colors.blue.withOpacity(0.3)
                                    : Colors.black.withOpacity(0.05),
                                spreadRadius: 0,
                                blurRadius: isSelected ? 15 : 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _getCategoryIcon(index),
                                color: isSelected
                                    ? Colors.white
                                    : Colors.blue[600],
                                size: 32,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                bookStore.listCategorias[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey[700],
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(int index) {
    final icons = [
      Icons.menu_book,
      Icons.science,
      Icons.favorite,
      Icons.psychology,
      Icons.history,
    ];
    return icons[index % icons.length];
  }

  // ...existing code...
  Widget _buildBooksGridSliver() {
    return Observer(
      builder: (_) {
        switch (bookStore.livrosCarregados) {
          case Status.CARREGANDO:
            return const SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
              ),
            );
          case Status.SUCESSO:
            final books = bookStore.listBooks;
            if (books.isEmpty) {
              return SliverToBoxAdapter(
                child: Container(
                  height: 200,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.book_outlined,
                          color: Colors.grey[400], size: 64),
                      const SizedBox(height: 16),
                      Text(
                        "Nenhum livro encontrado",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final book = books[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Modular.to.pushNamed(
                            '/initial/book/details/',
                            arguments: book,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              // Imagem do livro
                              Container(
                                width: 70,
                                height: 95,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      book.volumeInfo.imageLinks?.thumbnail ??
                                          book.volumeInfo.imageLinks
                                              ?.smallThumb ??
                                          'https://via.placeholder.com/70x95/f0f0f0/666666?text=Sem+Capa',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Informações do livro
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.volumeInfo.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF2D3748),
                                        height: 1.2,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    if (book.volumeInfo.authors != null)
                                      Text(
                                        book.volumeInfo.authors!.join(', '),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    const SizedBox(height: 4),
                                    if (book.volumeInfo.publishedDate != null)
                                      Text(
                                        'Publicado em ${book.volumeInfo.publishedDate}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        if (book.volumeInfo.categories !=
                                                null &&
                                            book.volumeInfo.categories!
                                                .isNotEmpty)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.blue[50],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              book.volumeInfo.categories!.first,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.blue[700],
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        const Spacer(),
                                        if (book.volumeInfo.averageRating !=
                                            null)
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber[600],
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                book.volumeInfo.averageRating
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Botão de favorito e seta
                              Column(
                                children: [
                                  Observer(
                                    builder: (_) => IconButton(
                                      onPressed: () =>
                                          bookStore.tornaLivroFavorito(book),
                                      icon: Icon(
                                        book.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: book.isFavorite
                                            ? Colors.red[400]
                                            : Colors.grey[400],
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey[400],
                                    size: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: books.length,
              ),
            );
          default:
            return const SliverToBoxAdapter(child: SizedBox());
        }
      },
    );
  }
// ...existing code...

  Widget _buildSearchResultsSliver() {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // ou 2 dependendo do tamanho desejado
          crossAxisSpacing: 12, // espaçamento horizontal entre itens
          mainAxisSpacing: 16, // espaçamento vertical entre itens
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Modular.to.pushNamed(
                    '/initial/book/details/',
                    arguments: bookStore.listBooksSearches[index],
                  );
                },
                child: BookWidget(book: bookStore.listBooksSearches[index]),
              ),
            );
          },
          childCount: bookStore.listBooksSearches.length,
        ),
      ),
    );
  }
}

class _BookRecomendedTile extends StatelessWidget {
  _BookRecomendedTile({super.key, required this.book});
  final Book book;
  final BookStore bookStore = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 160,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Modular.to.pushNamed(
              '/initial/book/details/',
              arguments: book,
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              book.volumeInfo.imageLinks?.thumbnail ??
                                  'https://via.placeholder.com/160x240',
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: GestureDetector(
                          onTap: () => bookStore.tornaLivroFavorito(book),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Icon(
                              book.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red[400],
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.volumeInfo.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                        Text(
                          book.volumeInfo.authors?.join(', ') ??
                              'Autor desconhecido',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
