import 'dart:developer';

import 'package:book_app/core/themes.dart';
import 'package:book_app/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BookTile extends StatelessWidget {
  BookTile({super.key, required this.book, this.onBookSelected});

  BookModel book;
  Function(BookModel book)? onBookSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBookSelected != null 
      ? () => onBookSelected!(book)
      : () {
        Modular.to.pushNamed('/initial/search/details', arguments: book);
      },
      child: Row( 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            image: DecorationImage(
                                image: NetworkImage(
                                    book.imagemUrl),
                                fit: BoxFit.cover),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 3.0,
                                spreadRadius: 0.05,
                                offset: const Offset(2, 1),
                              )
                            ]),
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.bookmark,
                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 1.0,
                                      spreadRadius: 0.03,
                                      offset: const Offset(1, 1))
                                ],
                              )))
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          book.title,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          book.author,
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          book.publisheDate ?? '',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          book.publisher ?? '',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 10, top: 5),
          //   child: GestureDetector(
          //       onTap: () {},
          //       child: Icon(
          //         Icons.favorite_border,
          //         color: Colors.black45,
          //         // shadows: (true) ? [
          //         //   BoxShadow(
          //         //     color: Colors.black.withOpacity(0.3),
          //         //     blurRadius: 2.0,
          //         //     spreadRadius: 0.03,
          //         //     offset: const Offset(1, 1),
          //         //   )
          //         // ] : null,
          //       )),
          // ),
        ],
      ),
    );
  }
}
