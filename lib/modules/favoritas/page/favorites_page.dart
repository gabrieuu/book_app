import 'package:book_app/core/model/book_model.dart';
import 'package:book_app/modules/favoritas/repository/favorite_repository.dart';
import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:book_app/modules/details/page/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({super.key});
  static String route = '/favoritas';
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  FavoritasStore favoritasStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: favoritasStore.listBooksFavorites.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return DetailsPage(book: favoritasStore.listBooksFavorites[index]);
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
                                    image: (favoritasStore.listBooksFavorites[index].volumeInfo.imageLinks!.smallThumb !=
                                            null)
                                        ? NetworkImage(
                                            favoritasStore.listBooksFavorites[index].volumeInfo.imageLinks!.smallThumb!)
                                        : NetworkImage(
                                            "http://via.placeholder.com/140x190"))),
                          ),SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(favoritasStore.listBooksFavorites[index].volumeInfo.title,style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(favoritasStore.listBooksFavorites[index].volumeInfo.authors[0],style: TextStyle(fontSize: 10),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
    );
  }
}