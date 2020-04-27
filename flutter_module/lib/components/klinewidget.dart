import 'package:flutter/material.dart';
import 'package:fluttermodule/kline/klineconstrants.dart';
import 'package:fluttermodule/components/klinegrid/klinePriceGridWidget.dart';
import 'package:fluttermodule/components/klinegrid/klineVolumeGridWidget.dart';
import 'package:fluttermodule/components/kline/klineCandleCrossWidget.dart';
import 'package:fluttermodule/components/kline/klineCandleInfoWidget.dart';
import 'package:fluttermodule/components/kline/klineCandleWidget.dart';
import 'package:fluttermodule/components/kline/klineLoadingWidget.dart';
import 'package:fluttermodule/components/kline/klineMaLineWidget.dart';
import 'package:fluttermodule/components/kline/klinePeriodSwitch.dart';
import 'package:fluttermodule/components/kline/klineVolumeWidget.dart';

class KLineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio:  _getTotalAspectRatio( context, kCandleAspectRatio, kVolumeAspectRatio, kPeriodAspectRatio),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              AspectRatio(
                child: KlinePeriodSwitchWidget(),
                aspectRatio: kPeriodAspectRatio,
              ), AspectRatio(
                aspectRatio: kCandleAspectRatio,
                child: Stack(
                  children: <Widget>[
                    KlinePriceGridWidget(),
                    KlineCandleWidget(),
                    KlineMaLineWidget(YKMAType.MA5),
                    KlineMaLineWidget(YKMAType.MA10),
                    KlineMaLineWidget(YKMAType.MA30),
                  ],
                ),
              ), AspectRatio(
                aspectRatio: kVolumeAspectRatio,
                child: Stack(
                  children: <Widget>[
                    KlineVolumeGridWidget(),
                    KlineVolumeWidget(),
                  ],
                ),
              ),
            ],
          ),
          KlineCandleCrossWidget(),
          KlineCandleInfoWidget(),
          KlineLoadingWidget(),
        ]
      ),
    );
  }

  double _getTotalAspectRatio(BuildContext context, double aspectRatio1, double aspectRatio2, double aspectRatio3) {
    if (aspectRatio1 == 0 || aspectRatio2 == 0 || aspectRatio3 == 0) { return 1; }
    double width = MediaQuery.of(context).size.width;
    double height1 = width / aspectRatio1;
    double height2 = width / aspectRatio2;
    double height3 = width / aspectRatio3;
    return width / (height1 + height2 + height3);
  }
}