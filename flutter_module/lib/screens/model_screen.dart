import 'package:flutter/material.dart';

class ModelScreen extends StatefulWidget {
  static String id = 'model_screen';
  @override
  _ModelScreenState createState() => _ModelScreenState();
}

class _ModelScreenState extends State<ModelScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Model'));
    ;
  }
}
