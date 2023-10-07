import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductsShimmer extends StatelessWidget {
  const ProductsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 15,
          childAspectRatio: 2 / 2.8,
          mainAxisSpacing: 15,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Shimmer(
            // baseColor:  const Color.fromARGB(255, 223, 216, 216),
            // highlightColor: const Color.fromARGB(255, 226, 221, 221),
            gradient:  const LinearGradient(colors: [
              Color.fromARGB(255, 226, 221, 221),
              Color.fromARGB(255, 226, 221, 221),              
            ]),
            child: Container(
              color: Colors.grey,
             ),
          );
        },
      ),
    );
  }
}
