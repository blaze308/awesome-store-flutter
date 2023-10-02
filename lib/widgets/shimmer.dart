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
          return Shimmer.fromColors(
            baseColor: Color.fromARGB(255, 227, 236, 236),
            highlightColor: Colors.blueGrey,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(color: Colors.grey, blurRadius: 2)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.centerLeft, child: Text("title")),
                  ),
                  SizedBox(
                    height: 150,
                    width: double.maxFinite,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Align(
                        alignment: Alignment.centerRight, child: Text("price")),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
