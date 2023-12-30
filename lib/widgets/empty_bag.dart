import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/widgets/subtitle_text.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';


class EmptyBagWidget extends StatelessWidget {
  const EmptyBagWidget(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.buttonText});

  final String imagePath, title, subtitle, buttonText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: size.height * 0.35,
              width: double.infinity,
            ),
            const TitleTextWidget(
              label: "Whoops!",
              fontSize: 40,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            SubtitleWidget(
              label: title,
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SubtitleWidget(
                label: subtitle,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.blue,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
