import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangolabs_test/app/controller/fetch_api.dart';
import 'package:mangolabs_test/app/global.dart';
import 'package:mangolabs_test/app/controller/home_screen_controller.dart';
import 'package:mangolabs_test/app/view/product_details_screen/product_details_screen.dart';
import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: lightGreen,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 1)
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: TextFormField(
                      controller: searchController,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: lightGreen),
                      decoration: const InputDecoration(
                        hintText: "Search any product",
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(Icons.mic),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              const Icon(
                Icons.shopping_basket,
                color: orangeColor,
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: buildTextWidget(
                  "Fruit & Vegetables",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(Icons.sort),
              const SizedBox(
                width: 15,
              ),
              Consumer<HomeScreenController>(builder: (context, provider, _) {
                return GestureDetector(
                  onTap: () {
                    provider.productDetails
                        ? provider.productDetailsUpdate(false)
                        : provider.productDetailsUpdate(true);
                  },
                  child: provider.productDetails
                      ? Icon(Icons.grid_view_rounded)
                      : Row(
                          children: [
                            Container(
                              color: greyColor,
                              height: 18,
                              width: 8,
                            ),
                            const SizedBox(
                              width: 2,
                              height: 24,
                            ),
                            Container(
                              color: greyColor,
                              height: 18,
                              width: 8,
                            ),
                          ],
                        ),
                );
              }),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder(
              future: fetchProduct(null),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: DynamicHeightGridView(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        builder: (context, index) {
                          return Consumer<HomeScreenController>(
                              builder: (context, provider, _) {
                            String image = snapshot.data![index]['image'];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                    category: snapshot.data![index]['category']
                                        .toString(),
                                    description: snapshot.data![index]
                                            ['description']
                                        .toString(),
                                    imageUrl: snapshot.data![index]['image']
                                        .toString(),
                                    title: snapshot.data![index]['title']
                                        .toString(),
                                    price: snapshot.data![index]['price']
                                        .toString(),
                                  ),
                                ));
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 200,
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: image,
                                              placeholder: (context, url) =>
                                                  shimmerContainer(), // Placeholder widget
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: Icon(
                                                    Icons.favorite_outline)),
                                          ],
                                        ),
                                      ),
                                      if (provider.productDetails)
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      buildTextWidget(
                                                          snapshot.data![index]
                                                                  ['title']
                                                              .toString(),
                                                          maxLines: 1,
                                                          textOverflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          textAlign:
                                                              TextAlign.start),
                                                    ],
                                                  ),
                                                ),
                                                buildTextWidget(
                                                  "₹${snapshot.data![index]['price']}",
                                                  color: greyColor,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            buildElevatedButton(
                                                onPressed: () {}, title: "Add"),
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                        itemCount: snapshot.data!.length,
                        crossAxisCount: 2,
                      ),
                    ),
                  );
                }
                return const Expanded(
                    child: SingleChildScrollView(
                        child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ShimmerGrid(),
                )));
              })
        ],
      )),
    );
  }
}
