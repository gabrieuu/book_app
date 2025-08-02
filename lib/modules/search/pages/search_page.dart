import 'package:book_app/modules/search/controller/busca_controller.dart';
import 'package:book_app/modules/search/widgets/list_books_search.dart';
import 'package:book_app/modules/search/widgets/list_users_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  Debouncer debouncer = Debouncer(delay: Duration(milliseconds: 300));
  final BuscaController controller = Modular.get();
  late TabController _tabController;
  bool _isSearching = false;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    controller.searchTextFieldController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    controller.searchTextFieldController.removeListener(_onSearchChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _showClearButton = controller.searchTextFieldController.text.isNotEmpty;
    });
  }

  void _clearSearch() {
    controller.searchTextFieldController.clear();
    controller.leitoresEncrontrados.clear();
    controller.livrosEncontrados.clear();
    setState(() {
      _showClearButton = false;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Modern Search Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page Title
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Descobrir',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),

                  // Enhanced Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _isSearching
                            ? Colors.blue[600]!
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: TextField(
                      controller: controller.searchTextFieldController,
                      onTap: () => setState(() => _isSearching = true),
                      onSubmitted: (_) => setState(() => _isSearching = false),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          controller.leitoresEncrontrados.clear();
                          controller.livrosEncontrados.clear();
                          setState(() => _isSearching = false);
                          return;
                        }

                        setState(() => _isSearching = true);

                        if (value.isNotEmpty) {
                          debouncer(() async {
                            await controller.buscar(value: value);
                            if (mounted) setState(() => _isSearching = false);
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Buscar livros e leitores...',
                        hintStyle: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: colorScheme.onSurfaceVariant,
                          size: 24,
                        ),
                        suffixIcon: _showClearButton
                            ? IconButton(
                                onPressed: _clearSearch,
                                icon: Icon(
                                  Icons.clear_rounded,
                                  color: colorScheme.onSurfaceVariant,
                                  size: 20,
                                ),
                              )
                            : _isSearching
                                ? Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation(
                                          Colors.blue[600]!,
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Enhanced Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                onTap: (value) {
                  controller.buscarPorTabBar(value);
                },
                indicator: BoxDecoration(
                  color: Colors.blue[600]!,
                  borderRadius: BorderRadius.circular(10),
                ),
                labelColor: colorScheme.onPrimary,
                unselectedLabelColor: colorScheme.onSurfaceVariant,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.book_rounded, size: 18),
                        SizedBox(width: 8),
                        Text('Livros'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_rounded, size: 18),
                        SizedBox(width: 8),
                        Text('Leitores'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content Area
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildContentWrapper(ListBooksSearch(), 'livros'),
                  _buildContentWrapper(ListUsers(), 'leitores'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentWrapper(Widget child, String type) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: controller.searchTextFieldController.text.isEmpty
          ? _buildEmptyState(type)
          : child,
    );
  }

  Widget _buildEmptyState(String type) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blue[600]!.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              type == 'livros' ? Icons.book_rounded : Icons.people_rounded,
              size: 48,
              color: Colors.blue[600]!,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Busque por ${type}',
            style: theme.textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Digite no campo acima para encontrar\n${type == 'livros' ? 'seus livros favoritos' : 'outros leitores'}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
