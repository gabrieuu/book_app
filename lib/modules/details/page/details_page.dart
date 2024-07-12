import 'package:book_app/model/book_model.dart';
import 'package:book_app/modules/details/details_controller.dart';
import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({super.key, required this.book});

  Book book;
  static String route = '/details';
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DetailsController detailsController = Modular.get();
  bool isFavorita = false;
  FavoritasStore favoritasStore = Modular.get();

  @override
  void initState() {
    super.initState();
    detailsController.book = widget.book;
    _initDetails();
  }

  _initDetails(){
    isFavorita = favoritasStore.isFavorita(widget.book);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [
            IconButton(
              onPressed: (){
                if(isFavorita){
                  favoritasStore.removeFavorita(widget.book);
                }else{
                  favoritasStore.addFavorite(widget.book);
                }
                setState(() {
                isFavorita = favoritasStore.isFavorita(widget.book);

                });
              },
              icon: Observer(builder: (_) {
                return (isFavorita)
                    ? const Icon(Icons.bookmark, color: Colors.red)
                    : const Icon(
                        Icons.bookmark_border,
                        color: Colors.black,
                      );
              },)
            ),
          ],
        ),
        bottomNavigationBar:
            ElevatedButton(onPressed: () {}, child: const Text("Ler agora")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 160,
                      height: 200,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:
                              (widget.book.volumeInfo.imageLinks!.smallThumb !=
                                      null)
                                  ? Image.network(
                                      widget.book.volumeInfo.imageLinks!
                                          .smallThumb!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      "http://via.placeholder.com/140x190")),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: 140,
                        //padding: const EdgeInsets.all(20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.book.volumeInfo.title,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                  maxLines: 3),
                              if (widget.book.volumeInfo.authors.isNotEmpty)
                                Text(
                                  "${widget.book.volumeInfo.authors[0]}",
                                  maxLines: 1,
                                ),
                              if (widget.book.volumeInfo.categories.isNotEmpty)
                                Text(
                                  "${widget.book.volumeInfo.categories[0]}",
                                  style: const TextStyle(fontSize: 11),
                                  maxLines: 1,
                                ),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Sobre o Livro",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      widget.book.volumeInfo.description,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
