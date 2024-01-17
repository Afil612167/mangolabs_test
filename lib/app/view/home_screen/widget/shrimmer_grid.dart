import 'package:flutter/widgets.dart';
import 'package:mangolabs_test/app/global.dart';

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
