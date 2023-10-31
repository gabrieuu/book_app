import 'package:book_app/data/bloc/book_bloc/book_bloc.dart';
import 'package:book_app/data/bloc/book_bloc/book_event.dart';
import 'package:book_app/data/bloc/book_bloc/book_state.dart';
import 'package:book_app/data/repository/book_repository.dart';
import 'package:book_app/data/service/auth_service/auth_service.dart';
import 'package:book_app/pages/details/details_page.dart';
import 'package:book_app/pages/home/book_widget.dart';
import 'package:book_app/pages/utils/menu_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var indexSelect = 0;
  bool isSelect = false;
  late BookBloc bloc;
  BookRepository repo = BookRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BookBloc();
    bloc.input.add(GetBooks(book: listCategorias[indexSelect]));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }

  final listCategorias = ["Java", "Flutter", "Kotlin", ".net", "c++", "PHP"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              (isSelect)
                  ? Expanded(
                      child: TextField(
                      onChanged: (string) {
                        if (string.isNotEmpty) {
                          bloc.input.add(GetBooks(book: string));
                        } else {
                          setState(() {
                            isSelect = !isSelect;
                          });
                        }
                      },
                      autofocus: true,
                      controller: repo.searchBook,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Busque um Livro'),
                    ))
                  : const Text(
                      "Book App",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSelect = !isSelect;
                });
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      drawer: Drawer(
        child: MenuDrawer()
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
                  child: ActionChip(
                    onPressed: () {
                      setState(() {
                        indexSelect = index;
                        bloc.input.add(GetBooks(book: listCategorias[index]));
                      });
                    },
                    label: Text(
                      listCategorias[index],
                      style: TextStyle(
                          color: (indexSelect == index)
                              ? Colors.white
                              : Colors.grey[600]),
                    ),
                    side: BorderSide.none,
                    backgroundColor:
                        (indexSelect == index) ? Colors.blue : Colors.grey[200],
                  ),
                );
              },
            ),
          ),
          Expanded(
              child: StreamBuilder<BookState>(
            stream: bloc.stream,
            builder: (context, state) {
              if (state.data is ErrorStateBook) {
                return Center(
                  child: Text((state.data as ErrorStateBook).mensagem),
                );
              }
              if (state.data is SucessStateBook) {
                final listBooks = (state.data as SucessStateBook).books;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.75,),
                  itemCount: listBooks.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DetailsPage(book: listBooks[index]);
                          },
                        ));
                      },
                      child: BookWidget(book: listBooks[index]),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
        ],
      ),
    );
  }
}
