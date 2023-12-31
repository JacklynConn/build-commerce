import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/widgets/subtitle_text.dart';

class CategoryRoundedWidget extends StatelessWidget {
  const CategoryRoundedWidget(
      {super.key, required this.name, required this.image});

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          height: 50,
          width: 50,
        ),
        const SizedBox(height: 15),
        SubtitleWidget(
          label: name,
          fontSize: 18,
          // fontWeight: FontWeight.bold,
        )
      ],
    );
  }
}
