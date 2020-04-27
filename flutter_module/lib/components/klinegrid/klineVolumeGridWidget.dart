import 'package:flutter/material.dart';
import 'package:fluttermodule/services/kline_bloc_service.dart';
import 'package:fluttermodule/services/kline_bloc_provider_service.dart';
import 'package:fluttermodule/kline/klinemodel.dart';
import 'package:fluttermodule/kline//klineconstrants.dart';

class KlineVolumeGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    KlineBloc bloc = KlineBlocProvider.of<KlineBloc>(context);
    return StreamBuilder(
      stream: bloc.currentKlineListStream,
      builder: (BuildContext context, AsyncSnapshot<List<KLineModel>> snapshot) {
        return CustomPaint(
          size: Size.infinite,
          painter: _VolumeGridPainter(bloc.volumeMax),
        );
      },
    );
  }
}

class _VolumeGridPainter extends CustomPainter {
  final double maxVolume;
  _VolumeGridPainter( this.maxVolume, );
  final Color lineColor = kGridLineColor;
  final double lineWidth = kGridLineWidth;
  final double columnTopMargin = kColumnTopMargin;
  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    Paint linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high;

    canvas.drawLine(Offset(0, columnTopMargin), Offset(width, columnTopMargin), linePaint);
    canvas.drawLine(Offset(0, height), Offset(width, height), linePaint);

    double widthOffset = (width ~/ kGridColumnCount).toDouble();
    for (int i = 1; i < kGridColumnCount; i ++) {
      canvas.drawLine(Offset(i * widthOffset, columnTopMargin),
          Offset(i * widthOffset, height), linePaint);
    }
    if (maxVolume == null) {
      return;
    }

    double originX = width - maxVolume.toStringAsPrecision(kGridPricePrecision).length * 6;
    _drawText(canvas, Offset(originX, columnTopMargin), maxVolume.toStringAsPrecision(kGridPricePrecision));
  }

  _drawText(Canvas canvas, Offset offset, String text) {
    TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            color: kGridTextColor,
            fontSize: kGridPriceFontSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) { return maxVolume != null; }
}