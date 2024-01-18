import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mangolabs_test/app/global.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(
      {required this.category,
      super.key,
      required this.description,
      required this.title,
      required this.imageUrl,
      required this.price});
  final String category;
  final String description;
  final String title;
  final String imageUrl;
  final String price;

  // final String

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  bool readMore = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: buildTextWidget(
          widget.category,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 8.0, right: 20, bottom: 20),
          child: Column(
            children: [
              productImageCard(width),
              const SizedBox(
                height: 20,
              ),
              productPriceAndNameRow(),
              const SizedBox(
                height: 20,
              ),
              productQuantityChangingCard(),
             const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  buildTextWidget("Description:",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              productDescriptionWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Card productQuantityChangingCard() {
    return Card(
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        if (quantity != 1) {
                          quantity--;
                          setState(() {});
                        }
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: orangeColor.withOpacity(.8),
                          child: const SizedBox(
                              width: 35,
                              child:
                                  Icon(Icons.remove, color: Colors.white))),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    buildTextWidget(quantity.toString(),
                        fontSize: 18, fontWeight: FontWeight.bold),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        quantity++;
                        setState(() {});
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: orangeColor.withOpacity(.8),
                          child: const SizedBox(
                              width: 35,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ))),
                    ),
                    const Spacer(),
                    buildElevatedButton(onPressed: () {}, title: "Add"),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            );
  }

  Row productPriceAndNameRow() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      buildTextWidget(widget.title,
                          maxLines: 7,
                          fontSize: 16,
                          textOverflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
                Column(
                  children: [
                    buildTextWidget(
                      "₹${widget.price}",
                      fontSize: 16,
                      color: greyColor,
                    ),
                  ],
                ),
              ],
            );
  }

  Card productImageCard(double width) {
    return Card(
              child: SizedBox(
                width: width - 40,
                height: width - 40,
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CachedNetworkImage(
                          imageUrl: widget.imageUrl,
                          placeholder: (context, url) =>
                              shimmerContainer(), // Placeholder widget
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.favorite_outline),
                    ),
                  ],
                ),
              ),
            );
  }

  Wrap productDescriptionWidget() {
    return Wrap(
              children: [
                buildTextWidget(
                  widget.description,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  maxLines: readMore ? 9999 : 2,
                  textOverflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                if (readMore == false)
                  GestureDetector(
                    onTap: () {
                      readMore = true;
                      setState(() {});
                    },
                    child: buildTextWidget(
                      "MORE",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: greyColor,
                      textAlign: TextAlign.start,
                    ),
                  ),
              ],
            );
  }
}
