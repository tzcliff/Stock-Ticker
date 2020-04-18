import 'package:flutter/material.dart';

import 'package:fluttermodule/models/enums.dart';
import 'package:fluttermodule/constants.dart';

class ModelItemDropdown extends StatelessWidget {
  final Function onChange;
  final StockItem selected;

  const ModelItemDropdown({
    Key key,
    this.onChange,
    this.selected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<StockItem>> dropDownItems = [];
    StockItem.values.forEach((item) {
      dropDownItems.add(DropdownMenuItem(
        child: Text(
          item.toString().split('.').last,
          style: kConditionalDropdownTextStyle,
        ),
        value: item,
      ));
    });
    return DropdownButton<StockItem>(
      value: selected,
      items: dropDownItems,
      onChanged: this.onChange,
    );
  }
}

class ModelTrendDropdown extends StatelessWidget {
  final Function onChange;
  final Trend selected;

  const ModelTrendDropdown({
    Key key,
    this.onChange,
    this.selected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<Trend>> dropDownItems = [];
    Trend.values.forEach((item) {
      dropDownItems.add(DropdownMenuItem(
        child: Text(
          item.toString().split('.').last,
          style: kConditionalDropdownTextStyle,
        ),
        value: item,
      ));
    });
    return DropdownButton<Trend>(
      value: selected,
      items: dropDownItems,
      onChanged: this.onChange,
    );
  }
}

class ModelPeriodDropdown extends StatelessWidget {
  final Function onChange;
  final int selected;

  const ModelPeriodDropdown({
    Key key,
    this.onChange,
    this.selected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<int>> dropDownItems = [];
    for (int i = 1; i <= 30; i++) {
      dropDownItems.add(DropdownMenuItem(
        value: i,
        child: Text(
          i.toString() + ' days',
          style: kConditionalDropdownTextStyle,
        ),
      ));
    }
    return DropdownButton<int>(
      value: selected,
      items: dropDownItems,
      onChanged: this.onChange,
    );
  }
}

class ModelSTDDropdown extends StatelessWidget {
  final Function onChange;
  final int selected;

  const ModelSTDDropdown({
    Key key,
    this.onChange,
    this.selected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<int>> dropDownItems = [];
    for (int i = 1; i <= 5; i++) {
      dropDownItems.add(DropdownMenuItem(
        value: i,
        child: Text(
          i.toString() + ' STDs',
          style: kConditionalDropdownTextStyle,
        ),
      ));
    }
    return DropdownButton<int>(
      value: selected,
      items: dropDownItems,
      onChanged: this.onChange,
    );
  }
}

class ModelActionDropdown extends StatelessWidget {
  final Function onChange;
  final UserAction selected;

  const ModelActionDropdown({
    Key key,
    this.onChange,
    this.selected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<UserAction>> dropDownItems = [];
    UserAction.values.forEach((item) {
      dropDownItems.add(DropdownMenuItem(
        child: Text(
          item.toString().split('.').last,
          style: kConditionalDropdownTextStyle,
        ),
        value: item,
      ));
    });
    return DropdownButton<UserAction>(
      value: selected,
      items: dropDownItems,
      onChanged: this.onChange,
    );
  }
}
