import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecomendadosShimmer extends StatelessWidget {
  const RecomendadosShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: const Color.fromARGB(255, 209, 209, 209),
        child: Container(
                  width: 130,
                  height: 160,
                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(35),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.0),
                                          Colors.black.withOpacity(1),
                                        ],
                                      ) 
                                    ),
                  
                ),);
  }
}

// Container(
//                                     width: 130,
//                                     height: 160,
//                                     decoration: BoxDecoration(
//                                       //color: Colors.grey[200],
//                                       borderRadius: BorderRadius.circular(35),
//                                       image: DecorationImage(
//                                         fit: BoxFit.cover,
//                                         image: NetworkImage(bookStore.recomendados[index].volumeInfo.imageLinks?.thumbnail ?? 'https://via.placeholder.com/140x190'),
//                                       ),
//                                       gradient: LinearGradient(
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter,
//                                         colors: [
//                                           Colors.black.withOpacity(0.0),
//                                           Colors.black.withOpacity(0.2),
//                                         ],
//                                       ),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 20, bottom: 15),
//                                       child: Align(
//                                         alignment: Alignment.bottomLeft,
//                                         child: Text('Livro $index')),
//                                     ),
//                                   ),