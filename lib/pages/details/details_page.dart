import 'package:book_app/data/model/book.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key, required this.book});

  Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_border))
        ],
      ),
      bottomNavigationBar: ElevatedButton(onPressed: (){}, child: Text("Ler agora")),
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
                    height: 230,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: (book.volumeInfo.imageLinks!.smallThumb != null)
                            ? Image.network(
                                book.volumeInfo.imageLinks!.smallThumb!,
                                fit: BoxFit.cover,
                              )
                            : Image.network("http://via.placeholder.com/140x190")),
                  ),
                  SizedBox(width: 10,),
                  Container(
                            alignment: Alignment.center,
                                width: 140,
                                //padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text(book.volumeInfo.title,style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.start,maxLines: 3),
                                  if(book.volumeInfo.authors.isNotEmpty) Text("${book.volumeInfo.authors[0]}", maxLines: 1,),
                                  if(book.volumeInfo.categories.isNotEmpty) Text("${book.volumeInfo.categories[0]}", style: const TextStyle(fontSize: 11), maxLines: 1,),
                                  ]
                                ),
                              )
                ],
              ),
              
            ),
           

            Container(
              width: MediaQuery.of(context).size.width*0.8,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text("Sobre o Livro", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  Text(book.volumeInfo.description, style: TextStyle(fontSize: 12, color: Colors.grey),textAlign: TextAlign.justify,)
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}