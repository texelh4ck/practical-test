import 'package:flutter/widgets.dart';
import 'package:practical_test/core/constants/const.dart';

class AppIcon extends StatelessWidget {
  final double size;

  const AppIcon({super.key, this.size = 150});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(APP_ICON),
            ),
          ),
        ),
      ],
    );
  }
}
