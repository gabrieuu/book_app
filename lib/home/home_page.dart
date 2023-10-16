import 'package:book_app/bloc/book_bloc.dart';
import 'package:book_app/bloc/book_event.dart';
import 'package:book_app/bloc/book_state.dart';
import 'package:book_app/home/book_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var indexSelect = 0;
  late BookBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BookBloc();
    bloc.input.add(GetBooks(book: "harry potter"));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }
  final listCategorias = [
    "Action",
    "Adventure",
    "Romance",
    "Tecnology",
    "health",
    "horror"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 55),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Navegação",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, left: 5),
                    child: Text(
                      "Recomendados",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 70,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 20),
                scrollDirection: Axis.horizontal,
                itemCount: listCategorias.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ActionChip(
                      onPressed: () {
                        setState(() {
                          indexSelect = index;
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
                      backgroundColor: (indexSelect == index)
                          ? Colors.blue
                          : Colors.grey[200],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: StreamBuilder<BookState>(
                stream: bloc.stream, 
                builder: (context, state) {
                  if(state.data is LoadingStateBook){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(state.data is SucessStateBook){
                    final listBooks = (state.data as SucessStateBook).books;
                    return ListView.builder(
                      itemCount: listBooks.length,
                      itemBuilder: (context, index) {
                        return BookWidget(book: listBooks[index]);
                      },
                    );
                  }
                  return Center(child: Text("Error"),);
                },)
            ),
          ],
        ),
      ),
    );
  }
}
