import 'package:flutter/material.dart';

class IconRoundButton extends StatelessWidget {
  final Function onPress;
  final IconData iconData;
  const IconRoundButton({
    this.onPress,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: this.onPress,
      child: Icon(
        this.iconData,
      ),
      shape: CircleBorder(),
      elevation: 2.0,
      fillColor: Colors.tealAccent.shade400,
      padding: const EdgeInsets.all(5.0),
    );
  }
}
