import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttermodule/services/kline_bloc_service.dart';
import 'package:fluttermodule/services/kline_bloc_provider_service.dart';
import 'package:fluttermodule/kline/klinemodel.dart';
import 'package:fluttermodule/kline/klineconstrants.dart';

class KlineCandleCrossWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    KlineBloc bloc = KlineBlocProvider.of<KlineBloc>(context);
    return StreamBuilder(
      stream: bloc.klineMarketStream,
      builder: (BuildContext context, AsyncSnapshot<KLineModel> snapshot) {
        KLineModel klineModel = snapshot.data;
        return klineModel == null
            ? Container()
            : klineModel.isShowCandleInfo
            ? CustomPaint(
          size: Size(bloc.screenWidth, klineModel?.gridTotalHeight),
          painter: _KlineCandleCrossPainter(
              snapshot.data, bloc.candlestickWidth),
        )
            : Container();
      },
    );
  }
}

class _KlineCandleCrossPainter extends CustomPainter {
  _KlineCandleCrossPainter(this.klineModel, this.crossVLineWidth);
  final KLineModel klineModel;
  final double crossVLineWidth;

  final Color crossHLineColor = kCrossHLineColor;
  final Color crossVLineColor = kCrossVLineColor;
  final double crossHLineWidth = kCrossHLineWidth;
  final double crossPointRadius = kCrossPointRadius;
  final Color crossPointColor = kCrossPointColor;
  @override
  void paint(Canvas canvas, Size size) {
    if (klineModel == null) {
      return;
    }
    double originY = klineModel.candleWidgetOriginY;
    Paint paintH = Paint()
      ..color = crossHLineColor
      ..strokeWidth = crossHLineWidth
      ..isAntiAlias = true;

    Paint paintV = Paint()
      ..color = crossVLineColor
      ..strokeWidth = crossVLineWidth
      ..isAntiAlias = true;

    canvas.drawLine(Offset(klineModel.offset.dx, originY),
        Offset(klineModel.offset.dx, klineModel.gridTotalHeight + originY), paintV);

    Paint pointPaint = Paint()..color = crossPointColor;
    Offset realOffset = Offset(klineModel.offset.dx, klineModel.offset.dy + originY);
    canvas.drawCircle(realOffset, crossPointRadius, pointPaint);
    
    TextPainter closePainter = TextPainter(
        text: TextSpan(
          text: klineModel.stock.close,
          style: TextStyle(
            color: kCandleTextColor,
            fontSize: kCandleFontSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr);
    closePainter.layout();
    double closeTextOriginX = 0;
    double crossHlineStartOriginX = 0;
    double crossHlineEndOriginX = 0;
    double hMargin = 1;
    double leftPadding = 4;
    double topPadding = 4;
    Offset offset1;
    Offset offset2;
    Offset offset3;
    Offset offset4;
    Offset offset5;
    double halfRectHeight = topPadding + closePainter.height / 2;
    double rectTopY = originY + klineModel.offset.dy - halfRectHeight;
    double rectBottomY = originY + klineModel.offset.dy + halfRectHeight;

    if (klineModel.offset.dx < size.width / 2) {
      closeTextOriginX = hMargin + leftPadding;
      crossHlineStartOriginX =
          leftPadding + hMargin + closePainter.width + halfRectHeight;
      crossHlineEndOriginX = size.width;
      offset1 = Offset(hMargin, rectTopY);
      offset2 = Offset(crossHlineStartOriginX - halfRectHeight, rectTopY);
      offset3 = Offset(crossHlineStartOriginX, originY + klineModel.offset.dy);
      offset4 = Offset(crossHlineStartOriginX - halfRectHeight, rectBottomY);
      offset5 = Offset(hMargin, rectBottomY);
    } else {
      closeTextOriginX =
          size.width - leftPadding - hMargin - closePainter.width;
      crossHlineStartOriginX = 0;
      crossHlineEndOriginX = closeTextOriginX - halfRectHeight;

      offset1 = Offset(size.width - hMargin, rectTopY);
      offset2 = Offset(crossHlineEndOriginX + halfRectHeight, rectTopY);
      offset3 = Offset(crossHlineEndOriginX, originY + klineModel.offset.dy);
      offset4 = Offset(crossHlineEndOriginX + halfRectHeight, rectBottomY);
      offset5 = Offset(size.width - hMargin, rectBottomY);
    }
    
    canvas.drawLine(Offset(crossHlineStartOriginX, klineModel.offset.dy + originY),
        Offset(crossHlineEndOriginX, klineModel.offset.dy + originY), paintH);
    List<Offset> points = [
      offset1,
      offset2,
      offset3,
      offset4,
      offset5,
      offset1
    ];

    Paint polygonPainter = Paint()
      ..color = kBackgroundColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    Path path = Path()..moveTo(offset1.dx, offset1.dy);
    path.addPolygon(points, false);
    canvas.drawPath(path, polygonPainter);

    canvas.drawPoints(PointMode.polygon, points, paintH);
    Offset of = Offset(
        closeTextOriginX, originY + klineModel.offset.dy - closePainter.height / 2);
    closePainter.paint(canvas, of);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return klineModel != null;
  }
}