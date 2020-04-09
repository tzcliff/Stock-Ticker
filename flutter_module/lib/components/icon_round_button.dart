import 'package:flutter/material.dart';

class IconRoundButton extends StatelessWidget {
  final Function onPress;
  final IconData iconData;
  final double size;
  const IconRoundButton({
    this.onPress,
    this.iconData,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: this.onPress,
      child: Icon(
        this.iconData,
        size: size,
      ),
      shape: CircleBorder(),
      elevation: 2.0,
      fillColor: Colors.tealAccent.shade400,
      padding: const EdgeInsets.all(5.0),
    );
  }
}
