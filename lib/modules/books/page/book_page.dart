import 'package:book_app/model/book_model.dart';
import 'package:book_app/modules/books/store/book_store.dart';
import 'package:book_app/modules/books/widgets/book_widget.dart';
import 'package:book_app/modules/books/widgets/recomendados_shimmer.dart';
import 'package:book_app/modules/home/controller/bottom_navigator_controller.dart';
import 'package:book_app/modules/home/widgets/appbar.dart';
import 'package:book_app/modules/home/widgets/menu_drawer.dart';
import 'package:book_app/modules/details/page/details_page.dart';
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

class _BookPageState extends State<BookPage> {
  BookStore bookStore = Modular.get();
  BottomNavigatorController navigator = Modular.get();
  final debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void clear() {
    bookStore.searchBook.clear();
    bookStore.searchIsSelect = false;
    bookStore.listBooksSearches.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookStore.searchBook.addListener(() {
      if (bookStore.searchBook.text.isEmpty ||
          bookStore.searchBook.text == '') {
        bookStore.listBooksSearches.clear();
        print('entrei bb');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await bookStore.fetchBookByCategory();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Observer(builder: (context) {
            return AppBarWidget(
              hintText: 'Busque um Livro',
            searchIsSelect: bookStore.searchIsSelect, 
            textFieldOnChanged: (string) async {
                          if (bookStore.searchBook.text.isEmpty) {
                            bookStore.listBooksSearches.clear();
                            setState(() {});
                          }
                          if (string.isNotEmpty) {
                            debouncer(() async {
                              print('atualizou');
                              await bookStore.searchBooks(string);
                            });
                          }
                        }, 
            textFieldController: bookStore.searchBook,
            backAction: clear,
            focusNode: _focusNode,
            searchIconAction: () {
                      if (!bookStore.searchIsSelect) {
                        bookStore.searchIsSelect = true;
                      }
                      bookStore.listBooksSearches.clear();
                      bookStore.searchBook.clear();
                    },
            
            );
          },),
        ),
        body: Observer(builder: (context) {
          return (bookStore.searchIsSelect)
            ? (bookStore.listBooksSearches.isEmpty)
                ? const Center(
                    child: Text("Não foi encontrado nenhum livro"),
                  )
                : ListView.builder(
                    itemCount: bookStore.listBooksSearches.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Modular.to.pushNamed(DetailsPage.route,
                              arguments: bookStore.listBooksSearches[index]);
                        },
                        child: BookWidget(
                          book: bookStore.listBooksSearches[index],
                        ),
                      );
                    },
                  )
            : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 210,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'Autores Recomendados',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 20,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                  bookStore.autores.length,
                                  (index) => Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              child: InkWell(
                                                onTap: (){
                                                  
                                                },
                                                child: CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage: AssetImage(
                                                      'assets/images/${bookStore.autores[index]}.jpg'),
                                                ),
                                              ),
                                            ), 
                                            SizedBox(
                                              width: 70,
                                              height: 40,
                                              child: Text(
                                                bookStore.autores[index],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                maxLines: 2,
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
      
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 10),
                            child: Row(
                              children: [
                                Text('Recomendados',
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w300)),
                                        SizedBox(width: 5,),
                                Icon(Icons.arrow_forward, size: 20)
                              ],
                            ),
                          ),
                          Expanded(
                            child: Observer(builder: (_){
                              switch (bookStore.livrosRecomendadosStatus) {
                                case Status.CARREGANDO:
                                  return ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(5, (index) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: RecomendadosShimmer()
                              )),    
                            );
                                case Status.ERRO:
                                  return const Center(
                                    child: Text("Ops, Aconteceu um erro"),
                                  );
                                case Status.SUCESSO:
                                  return ListView(
                                    padding: const EdgeInsets.only(left: 20),
                              scrollDirection: Axis.horizontal,
                              children: List.generate(bookStore.recomendados.length, (index) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        //color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(35),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(bookStore.recomendados[index].volumeInfo.imageLinks?.thumbnail ?? 'https://via.placeholder.com/140x190'),
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.0),
                                            Colors.black.withOpacity(0.2),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Modular.to.pushNamed(DetailsPage.route,
                                            arguments: bookStore.recomendados[index]);
                                      },
                                      child: Container(
                                         width: 130,
                                        height: 160,
                                        decoration: BoxDecoration(
                                          //color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(35),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.0),
                                              Colors.black.withOpacity(0.3),
                                              Colors.black.withOpacity(0.5),
                                              Colors.black.withOpacity(0.8),
                                            ],
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20, bottom: 15),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(bookStore.recomendados[index].volumeInfo.title, maxLines: 2 , style: TextStyle(color: Colors.white),)),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: InkWell(
                                        onTap: () {
                                          bookStore.tornaLivroFavorito(bookStore.recomendados[index]);
                                        },
                                        child: Icon(
                                          (bookStore.recomendados[index].isFavorite) ? Icons.favorite : Icons.favorite_border,
                                          color: Colors.red,
                                          shadows: [
                                            BoxShadow(
                                              color: Colors.white,
                                              spreadRadius: 0.9,
                                              blurRadius: 5,)
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),    
                            );
                                default:
                                  return Container();
                              }
                            })
                          )
                        ],
                      ),
                    ),
                  ),
      
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'Categorias',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 20,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 40,
                            child: Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                    5,
                                    (index) => Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 40,
                                                width: 80,
                                                child: InkWell(
                                                  radius: 10,
                                                  onTap: () {
                                                    bookStore.indexCategoriaSelecionada = index;
                                                    
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10),
                                                          color: (bookStore.indexCategoriaSelecionada == index)
                                                              ? Colors.blue[300]
                                                              : Colors
                                                                  .grey[200]
                                                          ),
                                                      child: Center(
                                                          child: Text(
                                                        bookStore
                                                                .listCategorias[
                                                            index],
                                                        style: TextStyle(
                                                            color:  (bookStore.indexCategoriaSelecionada == index) ? Colors.white : Colors.grey
                                                                ),
                                                      ))),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Observer(
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
                        List<Book> listBooks = bookStore.listBooks;
                        return SizedBox(
                            height: bookStore.listBooks.length/2 * 200.0,
                          child: GridView.count(
                            shrinkWrap: true,
                             physics: const NeverScrollableScrollPhysics(),
                             crossAxisCount: 2,
                             children: List.generate(listBooks.length, (index) => InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  Modular.to.pushNamed(DetailsPage.route,
                                      arguments: listBooks[index]);
                                },
                                child: BookWidget(book: listBooks[index]),
                              )),
                          ),
                        );
                      default:
                        return SizedBox();
                    }
                  },
                              ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            );
        },)
      ),
    );
  }
}
// Scaffold(
//       appBar: AppBar(
//         leading: Observer(builder: (_) {
//           return (bookStore.searchIsSelect) ? IconButton(
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.blue,
//               size: 20,
//             ),
//             onPressed: clear,
//           ) : const SizedBox();
//           }
//         ),
//         forceMaterialTransparency: true,
//         title: Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: Observer(
//               builder: (_) {
//                 return Row(
//                   children: [
//                     (bookStore.searchIsSelect)
//                         ? Expanded(
//                             child: TextField(
//                               focusNode: _focusNode,
//                             onChanged: (string) async {
                              
//                               if (string.isNotEmpty) {
//                                 debouncer(() async {
//                                   print('atualizou');
//                                   await bookStore.searchBooks(string);
//                                 });
//                               } else {
//                                 bookStore.searchIsSelect =
//                                     !bookStore.searchIsSelect;
//                               }
//                             },
//                             autofocus: true,
//                             controller: bookStore.searchBook,
//                             decoration: const InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: 'Busque um Livro'),
//                           ))
//                         : const Text(
//                             "Book App",
//                             style: TextStyle(
//                                 fontSize: 25, fontWeight: FontWeight.bold),
//                           ),
//                   ],
//                 );
//               },
//             )),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 bookStore.searchIsSelect = !bookStore.searchIsSelect;
//               },
//               icon: const Icon(Icons.search)),
//         ],
//       ),
//       body: GestureDetector(
//         onTap: () => _focusNode.unfocus(),
//         child: Column(
//           children: [
//             Observer(builder: (context) {
//               return (bookStore.searchIsSelect) 
//               ? SizedBox() 
//               : SizedBox(
//                 height: 70,
//                 child: ListView.builder(
//                 padding: const EdgeInsets.only(left: 20),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: bookStore.listCategorias.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: Observer(builder: (_) {
//                       return ActionChip(
//                         onPressed: () async {
//                           bookStore.indexActionChipSelect = index;
//                           await bookStore.fetchBookByCategory();
//                         },
//                         label: Text(
//                           bookStore.listCategorias[index],
//                           style: TextStyle(
//                               color: (bookStore.indexActionChipSelect == index)
//                                   ? Colors.white
//                                   : Colors.grey[600]),
//                         ),
//                         side: BorderSide.none,
//                         backgroundColor:
//                             (bookStore.indexActionChipSelect == index)
//                                 ? Colors.blue
//                                 : Colors.grey[200],
//                       );
//                     }),
//                   );
//                 },
//                             ),
//               );
//             },),
            // Expanded(
            //   child: Observer(
            //   builder: (_) {
            //     switch (bookStore.livrosCarregados) {
            //       case Status.CARREGANDO:
            //         return const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       case Status.ERRO:
            //         return const Center(
            //           child: Text("Ops, Aconteceu um erro"),
            //         );
            //       case Status.SUCESSO:
            //         List<Book> listBooks = bookStore.searchIsSelect
            //             ? bookStore.listBooksSearches
            //             : bookStore.listBooks;
            //         return GridView.builder(
            //           gridDelegate:
            //               const SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 2,
            //             childAspectRatio: 0.75,
            //           ),
            //           itemCount: listBooks.length,
            //           itemBuilder: (context, index) {
            //             return InkWell(
            //               borderRadius: BorderRadius.circular(10),
            //               onTap: () {
            //                 Modular.to.pushNamed(DetailsPage.route,
            //                     arguments: listBooks[index]);
            //               },
            //               child: BookWidget(book: listBooks[index]),
            //             );
            //           },
            //         );
            //       default:
            //         return Container();
            //     }
            //   },
            // )
            // );