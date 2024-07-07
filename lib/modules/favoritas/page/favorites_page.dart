import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:book_app/modules/details/page/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  static String route = '/favoritas';
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  FavoritasStore favoritasStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        return (favoritasStore.listBooksFavorites.isEmpty) 
        ? const Center(child: Text("Não possui favoritos")) 
        : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: favoritasStore.listBooksFavorites.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: (){
                        Modular.to.pushNamed(DetailsPage.route, arguments: favoritasStore.listBooksFavorites[index]);
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
                          ),const SizedBox(width: 10,),
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
            );
      },)
    );
  }
}
