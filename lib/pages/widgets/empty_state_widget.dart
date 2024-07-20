import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_plug/core/assets.dart';
import 'package:shoe_plug/core/spacing.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({required this.label, super.key});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(AppIcons.empty),
        ySpacing(12),
        Text(label),
      ],
    );
  }
}
