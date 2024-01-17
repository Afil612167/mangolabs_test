import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

const Color landingPageColor = Color(0xff377ded);
const Color brightGrey = Color(0xffFAFAFA);
const Color white = Colors.white;
const Color lightGreen = Color(0xffb3c2c5);
const Color greyColor = Color(0xffc8c8cc);
const Color orangeColor = Color(0xffF08F5F);

const Color lightBlack = Color(0xff2F2F2F);
Widget buildTextWidget(String data,
    {double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = lightBlack,
    TextAlign textAlign = TextAlign.center,
    double? height,
    int? maxLines,
    TextOverflow? textOverflow}) {
  return Text(
    data,
    textAlign: textAlign,
    overflow: textOverflow,
    maxLines: maxLines,
    style: GoogleFonts.poppins(
      height: height,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}

Widget buildElevatedButton(
    {required Function onPressed,
    Color backgroundcolor = orangeColor,
    required title,
    Color titleColor = white,
    double fontSize = 10,
    Widget? child,
    OutlinedBorder? shape}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundcolor,
      shape: shape,
    ),
    onPressed: () {
      onPressed();
    },
    child:
        child ?? buildTextWidget(title, color: titleColor, fontSize: fontSize),
  );
}

class ShimmerGrid extends StatelessWidget {
  const ShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
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
}

Widget shimmerContainer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
    ),
  );
}
