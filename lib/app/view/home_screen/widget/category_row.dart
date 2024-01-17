import 'package:flutter/material.dart';
import 'package:mangolabs_test/app/controller/home_screen_controller.dart';
import 'package:mangolabs_test/app/global.dart';
import 'package:provider/provider.dart';

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
            provider.productGridExpanded
                ? provider.productGridExpandedUpdate(false)
                : provider.productGridExpandedUpdate(true);
          },
          child: provider.productGridExpanded
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
