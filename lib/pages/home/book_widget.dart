import 'package:book_app/data/model/book_model.dart';
import 'package:flutter/material.dart';

class BookWidget extends StatelessWidget {
  BookWidget({super.key, required this.book});

  Book book;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 140,
            height: 190,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 0.1),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: (book.volumeInfo.imageLinks!.smallThumb != null) 
                ? NetworkImage(book.volumeInfo.imageLinks!.smallThumb!) : NetworkImage("http://via.placeholder.com/140x190"))
            ),
          ),
          Container(
            width: 140,
            child: Expanded(
              child: Column(            
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.volumeInfo.title,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                        maxLines: 1),
                    if (book.volumeInfo.authors.isNotEmpty)
                      Text(
                        "${book.volumeInfo.authors[0]}",
                        maxLines: 1,
                      ),
                    if (book.volumeInfo.categories.isNotEmpty)
                      Text(
                        "${book.volumeInfo.categories[0]}",
                        style: const TextStyle(fontSize: 11),
                        maxLines: 1,
                      ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
