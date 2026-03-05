// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class customTextButton extends StatelessWidget {
  const customTextButton({
    super.key,
    required this.text2,
    this.text,
    this.rout,
  });
  final String? text;
  final String? text2;
  final String? rout;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text ?? ""),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, rout!);
          },
          child: Text(text2 ?? ""),
        ),
      ],
    );
  }
}
