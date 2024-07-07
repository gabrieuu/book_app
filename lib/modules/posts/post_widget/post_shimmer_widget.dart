import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostShimmer extends StatelessWidget {
  const PostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: const Color.fromARGB(255, 209, 209, 209),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 50, height: 50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.grey),),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Container(height: 10, width: 100,color: Colors.grey,),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
                  child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Container(width: 350, height: 10, decoration: BoxDecoration(color: Colors.grey),),
                            SizedBox(height: 5,),
                            Container(width: 350, height: 10, decoration: BoxDecoration(color: Colors.grey),),
                            SizedBox(height: 5,),
                            Container(width: 350, height: 10, decoration: BoxDecoration(color: Colors.grey),),
                            SizedBox(height: 5,),
                            Container(width: 350, height: 10, decoration: BoxDecoration(color: Colors.grey),),
                            SizedBox(height: 5,),
                            Container(width: 350, height: 10, decoration: BoxDecoration(color: Colors.grey),),
                            SizedBox(height: 5,),
                         
                        ],
                      )),
                ),
      
              ],
            ),
        )
      ),
    );
  }
}