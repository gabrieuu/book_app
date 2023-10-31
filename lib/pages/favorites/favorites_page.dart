import 'package:book_app/data/bloc/favoritas_bloc/favoritas_bloc.dart';
import 'package:book_app/data/bloc/favoritas_bloc/favoritas_event.dart';
import 'package:book_app/data/bloc/favoritas_bloc/favoritas_state.dart';
import 'package:book_app/data/model/book_model.dart';
import 'package:book_app/data/service/favorite_service/favorite_service.dart';
import 'package:book_app/pages/details/details_page.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoritasBloc favoritasBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favoritasBloc = FavoritasBloc();
    favoritasBloc.inputEvent.add(GetAllFavoritas());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: favoritasBloc.stream,
        builder: (context, state) {
          if (state.data is LoadingFavoritasState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.data is SucessFullFavoritasState) {
            List<Book> listBooksFavorites =
                (state.data as SucessFullFavoritasState).booksFavorites;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: listBooksFavorites.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return DetailsPage(book: listBooksFavorites[index]);
                        },));
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 90,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black, width: 0.1),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: (listBooksFavorites[index].volumeInfo.imageLinks!.smallThumb !=
                                            null)
                                        ? NetworkImage(
                                            listBooksFavorites[index].volumeInfo.imageLinks!.smallThumb!)
                                        : NetworkImage(
                                            "http://via.placeholder.com/140x190"))),
                          ),SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(listBooksFavorites[index].volumeInfo.title,style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(listBooksFavorites[index].volumeInfo.authors[0],style: TextStyle(fontSize: 10),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Center(
            child: Text("Error"),
          );
        },
      ),
    );
  }
}
