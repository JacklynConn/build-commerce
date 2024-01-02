import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/screens/search_screen.dart';
import 'package:flutter_build_ecommerce/widgets/subtitle_text.dart';

class CategoryRoundedWidget extends StatelessWidget {
  const CategoryRoundedWidget(
      {super.key, required this.name, required this.image});

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()  {
         Navigator.pushNamed(
          context,
          SearchScreen.routeName,
          arguments: name,
        );
      },
      child: Column(
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          const SizedBox(height: 5),
          SubtitleWidget(
            label: name,
            fontSize: 15,
            // fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
