// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesomestore/models/products.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import 'package:awesomestore/api/product_api.dart';

import '../widgets/shimmer.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;
  final String category;
  const ProductDetailPage({
    Key? key,
    required this.productId,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Awesome Store"),
      ),
      body: ListView(
        children: [
          FutureBuilder(
            future: ProductsApi().fetchProductDetail(context, productId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ProductsShimmer();
              } else if (snapshot.hasData) {
                var product = snapshot.data;

                return Wrap(
                  children: [
                    SizedBox(
                        width: double.maxFinite,
                        height: 250,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                product["thumbnail"],
                                fit: BoxFit.cover,
                              )),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Text(product["title"],
                          maxLines: 3,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18)),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Text(
                              "GHC ${product["price"]}".toString(),
                              style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF869013)),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.remove_circle,
                                        color: Colors.redAccent, size: 25)),
                                const badges.Badge(
                                  badgeContent: Text("3"),
                                  badgeStyle: badges.BadgeStyle(
                                      badgeColor: Colors.white),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add_circle,
                                        color: Colors.greenAccent, size: 25)),
                              ]),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF57FD5E),
                                  fixedSize: const Size(100, 20),
                                ),
                                child: const Text(
                                  "Add to Cart",
                                  style: TextStyle(fontSize: 12),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text(product["description"], maxLines: 7),
                      ),
                    ),
                  ],
                );
              } else {
                return const Text("no data");
              }
            },
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text("Similar and Related Products "),
          ),
          FutureBuilder(
            future: ProductsApi().fetchProductCategory(context, category),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ProductsShimmer();
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2 / 2.8,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var product = snapshot.data[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                category: category,
                                productId: Product.fromMap(product).id!,
                              ),
                            ));
                          },
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
                                      alignment: Alignment.centerLeft,
                                      child:
                                          Text(Product.fromMap(product).title)),
                                ),
                                SizedBox(
                                  height: 150,
                                  width: double.maxFinite,
                                  child: Image.network(
                                    Product.fromMap(product).thumbnail,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        "GHC ${Product.fromMap(product).price}"
                                            .toString()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text("error😣: Data Not Found"),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
