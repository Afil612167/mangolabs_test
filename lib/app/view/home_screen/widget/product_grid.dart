import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mangolabs_test/app/global.dart';
import 'package:mangolabs_test/app/model/product_grid_style_enum.dart';
import 'package:mangolabs_test/app/model/product_model.dart';
import 'package:mangolabs_test/app/view/product_details_screen/product_details_screen.dart';

import '../../../controller/home_screen_controller.dart';

GestureDetector productGrid(
    BuildContext context,
    AsyncSnapshot<List<ProductModel>> snapshot,
    int index,
    String image,
    HomeScreenController provider) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          category: snapshot.data![index].category.toString(),
          description: snapshot.data![index].description.toString(),
          imageUrl: snapshot.data![index].image.toString(),
          title: snapshot.data![index].title.toString(),
          price: snapshot.data![index].price.toString(),
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
                                snapshot.data![index].title.toString(),
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      buildTextWidget(
                        "₹${snapshot.data![index].price}",
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
