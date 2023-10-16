import 'package:book_app/model/book.dart';
import 'package:flutter/material.dart';

class BookWidget extends StatelessWidget {
  BookWidget({super.key, required this.book});

  Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
                    width: 200,
                    height: 240,
                    padding: EdgeInsets.symmetric(horizontal: 40,),
                    margin: EdgeInsets.only(bottom: 20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [                    
                         
                        Align(
                          alignment: Alignment.centerRight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: (book.volumeInfo.imageLinks!.smallThumb != null) ? Image.network(book.volumeInfo.imageLinks!.smallThumb!,fit: BoxFit.cover,) : Image.network("http://via.placeholder.com/140x190")
                            )
                        ),
                                    
                        Align(
                          alignment: Alignment.centerLeft,                     
                          child: Container(
                            width: 190,
                            height: 190,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(                             
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  spreadRadius: 1
                                )
                              ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(book.volumeInfo.title,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.start,maxLines: 3),
                                if(book.volumeInfo.authors.isNotEmpty) Text("${book.volumeInfo.authors[0]}"),
                                Text("xxx views"),
                                ]
                              ),
                            ),
                          ),
                        ),
                       
                        
                      ],
                    ),
                  );
  }
}