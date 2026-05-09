import 'package:book_app/model/book_model.dart';
import 'package:book_app/modules/search/controller/busca_controller.dart';
import 'package:book_app/modules/search/widgets/list_books_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NewPostBookSearch extends StatefulWidget {
  NewPostBookSearch({super.key, this.onBookSelected});

  Function(BookModel book)? onBookSelected;

  @override
  State<NewPostBookSearch> createState() => _NewPostBookSearchState();
}

class _NewPostBookSearchState extends State<NewPostBookSearch> {
  BuscaController buscaController = Modular.get();


  @override
  void dispose() {
    super.dispose();
    buscaController.searchTextFieldController.clear();
    buscaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final hasBooks = buscaController.livrosEncontrados.isNotEmpty;
      
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        constraints: BoxConstraints(
          minHeight: 80,
          maxHeight: hasBooks 
              ? MediaQuery.of(context).size.height * 0.6
              : 80,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasBooks)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: ListBooksSearch(
                    onBookSelected: widget.onBookSelected,
                  ),
                ),
              ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: buscaController.searchTextFieldController,
                onChanged: buscaController.onChangeTextField,
                decoration: InputDecoration(
                  hintText: 'Pesquisar livro...',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  suffixIcon: buscaController.searchTextFieldController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                          onPressed: () {
                            buscaController.searchTextFieldController.clear();
                            buscaController.clear();
                          },
                        )
                      : IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.keyboard_arrow_down_outlined, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}