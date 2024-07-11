import 'package:book_app/modules/books/store/book_store.dart';
import 'package:book_app/modules/books/widgets/book_widget.dart';
import 'package:book_app/modules/home/controller/bottom_navigator_controller.dart';
import 'package:book_app/modules/home/widgets/menu_drawer.dart';
import 'package:book_app/modules/details/page/details_page.dart';
import 'package:book_app/core/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});
  static String rota = '/book';
  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  BookStore bookStore = Modular.get();
  BottomNavigatorController navigator = Modular.get();

  final listCategorias = ["Java", "Flutter", "Kotlin", ".net", "c++", "PHP"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue, size: 20,),
          onPressed: () => navigator.currentIndex = 0,
        ),
        forceMaterialTransparency: true,
        title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Observer(
              builder: (_) {
                return Row(
                  children: [
                    (bookStore.searchIsSelect)
                        ? Expanded(
                            child: TextField(
                            onChanged: (string) async {
                              if (string.isNotEmpty) {
                                await bookStore.fetchAllBooks(string);
                              } else {
                                bookStore.searchIsSelect =
                                    !bookStore.searchIsSelect;
                              }
                            },
                            autofocus: true,
                            controller: bookStore.searchBook,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Busque um Livro'),
                          ))
                        : const Text(
                            "Book App",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                  ],
                );
              },
            )),
        actions: [
          IconButton(
              onPressed: () {
                bookStore.searchIsSelect = !bookStore.searchIsSelect;
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 20),
              scrollDirection: Axis.horizontal,
              itemCount: listCategorias.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Observer(builder: (_) {
                    return ActionChip(
                      onPressed: () async {
                        bookStore.indexActionChipSelect = index;
                        await bookStore.fetchAllBooks(listCategorias[index]);
                      },
                      label: Text(
                        listCategorias[index],
                        style: TextStyle(
                            color: (bookStore.indexActionChipSelect == index)
                                ? Colors.white
                                : Colors.grey[600]),
                      ),
                      side: BorderSide.none,
                      backgroundColor:
                          (bookStore.indexActionChipSelect == index)
                              ? Colors.blue
                              : Colors.grey[200],
                    );
                  }),
                );
              },
            ),
          ),
          Expanded(child: Observer(
            builder: (_) {
              switch (bookStore.livrosCarregados) {
                case Status.CARREGANDO:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.ERRO:
                  return const Center(
                    child: Text("Ops, Aconteceu um erro"),
                  );
                case Status.SUCESSO:
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: bookStore.listBooks.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Modular.to.pushNamed(DetailsPage.route, arguments: bookStore.listBooks[index]);               
                        },
                        child: BookWidget(book: bookStore.listBooks[index]),
                      );
                    },
                  );
                default:
                  return Container();
              }
            },
          )),
        ],
      ),
    );
  }
}
