import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.size,
    this.color,
    this.style,
    this.buttonStyle,
  }) : super(key: key);

  final ButtonStyle? buttonStyle;
  final HeroIcons icon;
  final double? size;
  final VoidCallback onPressed;
  final Color? color;
  final HeroIconStyle? style;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: IconButton(
        style: buttonStyle,
        icon: HeroIcon(
          icon,
          size: size ?? 24,
          color: color ?? Colors.black,
          style: style,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
