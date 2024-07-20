import 'package:book_app/model/book_model.dart';
import 'package:flutter/material.dart';

class BookWidget extends StatelessWidget {
  BookWidget({super.key, required this.book});

  Book book;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 130,
          height: 160,
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
        Center(
          child: Text(book.volumeInfo.title.trim(),
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
              maxLines: 1),
        ),
      ],
    );
  }
}
