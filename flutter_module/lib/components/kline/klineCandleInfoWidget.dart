import 'package:flutter/material.dart';
import 'package:fluttermodule/services/kline_bloc_service.dart';
import 'package:fluttermodule/services/kline_bloc_provider_service.dart';
import 'package:fluttermodule/kline/klinemodel.dart';
import 'package:fluttermodule/kline/klineconstrants.dart';

class KlineCandleInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> _list = ['Time', 'Open', 'High', 'Low', 'Close', 'UpDownAmount', 'UpDownPercent', 'Volume'];
    KlineBloc bloc = KlineBlocProvider.of<KlineBloc>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double width = kCandleInfoWidth;
    double height = kCandleInfoHeight;
    double rightLeftMargin = screenWidth - width - kCandleInfoLeftMargin;
    double rowTotalHeight = height - kCandleInfoPadding.top - kCandleInfoPadding.bottom;
    double rowHeight = (rowTotalHeight / _list.length);

    return StreamBuilder(
      stream: bloc.klineMarketStream,
      builder: (BuildContext context, AsyncSnapshot<KLineModel> snapshot) {
        KLineModel klinemodel = snapshot.data;
        double originY = klinemodel?.candleWidgetOriginY;
        Container _candleInfoWidget() {
          return Container(
            width: width,
            height: height,
            margin: (klinemodel.offset.dx > screenWidth / 2)
                ? EdgeInsets.only(
                top: kCandleInfoTopMargin + originY,
                left: kCandleInfoLeftMargin)
                : EdgeInsets.only(
                top: kCandleInfoTopMargin + originY, left: rightLeftMargin),
            decoration: BoxDecoration(
                border: Border.all(
                    color: kCandleInfoBorderColor,
                    width: kCandleInfoBorderWidth),
                color: kCandleInfoBgColor),
            child: ListView.builder(
              padding: kCandleInfoPadding,
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                List<String> marketInfoList = klinemodel?.candleInfo();
                return Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: rowHeight,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${_list[index]}',
                          style: TextStyle(
                              color: kCandleInfoTextColor,
                              fontSize: kCandleInfoLeftFontSize),
                        ),
                      ),
                      Container(
                        height: rowHeight,
                        alignment: Alignment.centerRight,
                        child: marketInfoList == null
                            ? Text('')
                            : Text(
                          '${marketInfoList[index]}',
                          style: TextStyle(
                              color: _list[index].contains('Up')
                                  ? marketInfoList[index].contains('+')
                                  ? kIncreaseColor
                                  : kDecreaseColor
                                  : kCandleInfoTextColor,
                              fontSize: kCandleInfoRightFontSize),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }

        return klinemodel == null
            ? Container()
            : (klinemodel.isShowCandleInfo ? _candleInfoWidget() : Container());
      },
    );
  }
}