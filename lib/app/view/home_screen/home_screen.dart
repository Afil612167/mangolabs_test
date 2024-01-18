import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mangolabs_test/app/global.dart';
import 'package:mangolabs_test/app/controller/home_screen_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mangolabs_test/app/model/product_grid_style_enum.dart';
import 'package:mangolabs_test/app/model/product_model.dart';
import 'package:mangolabs_test/app/view/product_details_screen/product_details_screen.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<HomeScreenController>().fetchProducts();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          buildSearchAndCartRow(searchController),
          const Divider(),
          categoryRow(),
          const SizedBox(
            height: 10,
          ),
          Consumer<HomeScreenController>(builder: (context, provider, _) {
            if (provider.isProductApiLoading == false) {
              return Expanded(
                  child: SingleChildScrollView(
                      child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildShimmer(),
              )));
            } else if (provider.productApiError != "") {
              return buildTextWidget('Error: ${provider.productApiError}');
            } else {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: DynamicHeightGridView(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    builder: (context, index) {
                      return Consumer<HomeScreenController>(
                          builder: (context, provider, _) {
                        String image = provider.products[index].image;
                        return productGrid(
                            context, provider.products, index, image, provider);
                      });
                    },
                    itemCount: provider.products.length,
                    crossAxisCount: 2,
                  ),
                ),
              );
            }
          })
        ],
      )),
    );
  }

  Widget buildShimmer() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1 / 1.2),
      itemCount: 10, // Replace with your actual item count
      itemBuilder: (context, index) {
        return shimmerContainer();
      },
    );
  }

  Row categoryRow() {
    return Row(
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
              if (provider.productGridStyle == ProductGridStyles.style1) {
                provider.productGridExpandedUpdate(ProductGridStyles.style2);
              } else {
                provider.productGridExpandedUpdate(ProductGridStyles.style1);
              }
            },
            child: provider.productGridStyle == ProductGridStyles.style1
                ? const Icon(Icons.grid_view_rounded)
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
    );
  }

  GestureDetector productGrid(BuildContext context, List<ProductModel> snapshot,
      int index, String image, HomeScreenController provider) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
            category: provider.products[index].category.toString(),
            description: provider.products[index].description.toString(),
            imageUrl: provider.products[index].image.toString(),
            title: provider.products[index].title.toString(),
            price: provider.products[index].price.toString(),
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
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Icon(Icons.favorite_outline)),
                  ],
                ),
              ),
              if (provider.productGridStyle == ProductGridStyles.style1)
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              buildTextWidget(
                                  provider.products[index].title.toString(),
                                  maxLines: 1,
                                  textOverflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start),
                            ],
                          ),
                        ),
                        buildTextWidget(
                          "₹${provider.products[index].price}",
                          color: greyColor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    buildElevatedButton(onPressed: () {}, title: "Add"),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Row buildSearchAndCartRow(TextEditingController searchController) {
    return Row(
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
    );
  }
}
