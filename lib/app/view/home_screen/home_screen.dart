import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';


import 'package:mangolabs_test/app/global.dart';
import 'package:mangolabs_test/app/controller/home_screen_controller.dart';

import 'package:mangolabs_test/app/view/home_screen/widget/category_row.dart';
import 'package:mangolabs_test/app/view/home_screen/widget/product_grid.dart';
import 'package:mangolabs_test/app/view/home_screen/widget/search_and_cart_row.dart';

import 'package:mangolabs_test/app/view/home_screen/widget/shrimmer_grid.dart';
import 'package:provider/provider.dart';

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
          FutureBuilder(
              future: HomeScreenController().fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                      child: SingleChildScrollView(
                          child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ShimmerGrid(),
                  )));
                } else if (snapshot.hasError) {
                  return buildTextWidget('Error: ${snapshot.error}');
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
                            String image = snapshot.data![index].image;
                            return productGrid(
                                context, snapshot, index, image, provider);
                          });
                        },
                        itemCount: snapshot.data!.length,
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
}
