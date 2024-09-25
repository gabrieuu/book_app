import 'dart:developer';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:book_app/core/themes.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/modules/book_details/details_controller.dart';
import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
  bool expandableText = false;

  @override
  void initState() {
    super.initState();
    detailsController.book = widget.book;
    _initDetails();
  }

  _initDetails() {
    isFavorita = favoritasStore.isFavorita(widget.book);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Themes.branco,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.47,
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  widget.book.volumeInfo.imageLinks.thumbnail),
                              opacity: 0.8,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Stack(
                              children: [
                                Container(
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Themes.branco,
                                            Themes.branco.withOpacity(0.2),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 3, sigmaY: 3), // Intensidade do blur
                          child: Container(
                            color: Colors.black.withOpacity(
                                0), // O container precisa ser parcialmente transparente
                          ),
                        ),
                        Positioned(
                          left: 5,
                          top: MediaQuery.of(context).size.height * 0.03,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back)),
                        ),
                        Positioned(
                          right: 5,
                          top: MediaQuery.of(context).size.height * 0.03,
                          child: IconButton(onPressed: () {
                            if (isFavorita) {
                              favoritasStore.removeFavorita(widget.book);
                            } else {
                              favoritasStore.addFavorite(book: widget.book);
                            }
                            setState(() {
                              isFavorita =
                                  favoritasStore.isFavorita(widget.book);
                            });
                          }, icon: Observer(
                            builder: (_) {
                              return (isFavorita)
                                  ? const Icon(Icons.favorite,
                                      color: Colors.red)
                                  : const Icon(
                                      Icons.favorite_border,
                                      color: Colors.black,
                                    );
                            },
                          )),
                        ),
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.15,
                      left: MediaQuery.of(context).size.width * 0.27,
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.32,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              image: DecorationImage(
                                  image: NetworkImage(widget
                                      .book.volumeInfo.imageLinks.smallThumb),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.bottomCenter),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.bookmark_add,
                                color: Colors.white,
                                size: MediaQuery.of(context).size.width * 0.07,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 1.0,
                                    spreadRadius: 0.03,
                                    offset: const Offset(1, 1),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RatingBarIndicator(
                rating: 3.3,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  size: 15,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: AutoSizeText(
                        widget.book.volumeInfo.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        minFontSize: 15,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  AutoSizeText(
                    widget.book.volumeInfo.authors.join(', '),
                    style: const TextStyle(fontSize: 15),
                    minFontSize: 10,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(widget.book.volumeInfo.publishedDate
                              .split('-')
                              .first),
                          Text('Publicado em')
                        ],
                      ),
                      Column(
                        children: [
                          Text('${widget.book.volumeInfo.pageCount}'),
                          Text('Páginas')
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Sobre o Livro",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          expandableText = !expandableText;
                        });
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: (expandableText)
                                ? null
                                : MediaQuery.of(context).size.height * 0.1,
                            child: SizedBox(
                              child: Html(
                                data: widget.book.volumeInfo.description!,
                                style: {
                                  "b": Style(
                                    fontSize: FontSize(15),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  "p": Style(
                                    fontSize: FontSize(15),
                                    color: Colors.black,
                                  ),
                                },
                              ),
                            ),
                          ),
                          Icon(
                            (expandableText)
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
