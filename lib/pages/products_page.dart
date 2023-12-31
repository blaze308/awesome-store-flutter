import 'package:awesomestore/api/product_api.dart';
import 'package:awesomestore/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import '../models/products.dart';
import '../widgets/shimmer/products_shimmer.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Awesome Store")),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Awesome Products to use in Eternity")),
            ),
            FutureBuilder(
              future: ProductsApi().fetchProducts(context),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ProductsShimmer();
                } else if (snapshot.hasData) {
                  return Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 15,
                            childAspectRatio: 2 / 2.8,
                            mainAxisSpacing: 15,
                          ),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            Product product =
                                Product.fromMap(snapshot.data[index]);
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailPage(
                                          product: product,
                                          productId: product.id!,
                                          category: product.category),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            product.title,
                                            maxLines: 1,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 150,
                                      width: double.maxFinite,
                                      child: Image.network(
                                        product.thumbnail,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                            "GHC ${product.price.toString()}"),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }));
                } else {
                  return const Text("no data");
                }
              },
            )
          ],
        ));
  }
}
