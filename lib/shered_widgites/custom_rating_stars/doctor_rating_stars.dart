import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

/// A reusable star-rating display widget.
/// Shows filled, half, and empty stars based on [rating].
class DoctorRatingStars extends StatelessWidget {
  final double rating;
  final double starSize;
  final bool showLabel;

  const DoctorRatingStars({
    super.key,
    required this.rating,
    this.starSize = 16,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (index) {
          final filled = index < rating.floor();
          final half = !filled && index < rating;
          return Icon(
            filled
                ? Icons.star_rounded
                : half
                    ? Icons.star_half_rounded
                    : Icons.star_outline_rounded,
            color: ColorsManager.yellow,
            size: starSize,
          );
        }),
        if (showLabel) ...[
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: starSize * 0.85,
              fontWeight: FontWeight.w600,
              color: ColorsManager.gray,
            ),
          ),
        ],
      ],
    );
  }
}
