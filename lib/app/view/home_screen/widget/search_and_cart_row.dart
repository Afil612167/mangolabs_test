  import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mangolabs_test/app/global.dart';

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
