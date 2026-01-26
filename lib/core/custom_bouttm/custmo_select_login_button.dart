import 'package:flutter/material.dart';
import 'package:graduation_project/core/resources/colors_manager.dart';

class CustmoSelectLoginButton extends StatelessWidget {
  const CustmoSelectLoginButton({
    super.key,
    required this.text,
    required this.text2,
    required this.image,
    this.isSelected = false,
    this.onTap,
  });

  final String text;
  final String text2;
  final String image;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,

              color: isSelected
                  ? ColorsManager.purble
                  : ColorsManager.lightGray,
              size: 20,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                alignment: Alignment.topCenter,
              ),
              border: Border.all(
                style: BorderStyle.solid,
                color: isSelected
                    ? ColorsManager.purble
                    : ColorsManager.lightGray,
                width: 2,
                // style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            height: height * 0.244,
            width: width * 0.40,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.0615,
                vertical: height * 0.00995,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(text2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
