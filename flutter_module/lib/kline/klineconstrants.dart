import 'package:flutter/material.dart';

const double kPeriodHeight = 40;
const double kPeriodAspectRatio = 375 / kPeriodHeight;
const String kDefaultPeriod = '1day';
const List<String> kPeriodList = ['1min', '5min', '15min', '30min', '60min', '1day'];
const kDefaultPeriodIndex = 5;

const double kCandlestickWidth = 7.0;
const double kWickWidth = 1.0;
const double kCandlestickGap = 2.0;
const double kTopMargin = 30.0;
const Color kDecreaseColor = Colors.red;
const Color kIncreaseColor = Colors.green;
const Color kBackgroundColor = Color(0xff2E2E2E);
const double kCandleAspectRatio = 1;
const Color kCandleTextColor = Colors.white;
const double kCandleFontSize = 9;
const double kCandleTextHeight = 12;

const double kColumnarWidth = kCandlestickWidth;
const double kColumnarGap = kCandlestickGap;
const double kColumnarTopMargin = 32.0;
const double kVolumeAspectRatio = 1/0.25;

const Color kGridLineColor = Colors.grey;
const Color kGridTextColor = Colors.white;
const double kGridLineWidth = 0.5;
const double kGridPriceFontSize = 10;
const int kGridRowCount = 4;
const int kGridColumnCount = 5;
const int kGridPricePrecision = 7;
const double kColumnTopMargin = 20.0;

const double kMaLineWidth = 1.0;
const double kMaTopMargin = kTopMargin;
const Color kMa5LineColor = Color(0xffF1DB9D);
const Color kMa10LineColor = Color(0xff81CEBF);
const Color kMa20LineColor = Color(0xffC097F6);

const Color kCrossHLineColor = Colors.white;
const Color kCrossVLineColor = Colors.white12;
const Color kCrossPointColor = Colors.white;
const double kCrossHLineWidth = 0.5;
const double kCrossVLineWidth = kCandlestickGap;
const double kCrossPointRadius = 2.0;
const double kCrossTopMargin = 0;

const Color kCandleInfoBgColor = Color(0xff2E2E2E);
const Color kCandleInfoBorderColor = Colors.grey;
const Color kCandleInfoTextColor = Colors.white;
const Color kCandleInfoDecreaseColor = kDecreaseColor;
const Color kCandleInfoIncreaseColor = kIncreaseColor;
const double kCandleInfoLeftFontSize = 10;
const double kCandleInfoRightFontSize = 10;
const double kCandleInfoLeftMargin = 5;
const double kCandleInfoTopMargin = 20;
const double kCandleInfoBorderWidth = 1;
const EdgeInsets kCandleInfoPadding = EdgeInsets.fromLTRB(5, 3, 5, 3);
const double kCandleInfoWidth = 130;
const double kCandleInfoHeight = 137;

enum YKMAType {
  MA5,
  MA10,
  MA30
}