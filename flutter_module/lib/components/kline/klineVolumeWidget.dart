import 'package:flutter/material.dart';
import 'package:fluttermodule/services/kline_bloc_service.dart';
import 'package:fluttermodule/services/kline_bloc_provider_service.dart';
import 'package:fluttermodule/kline/klinemodel.dart';
import 'package:fluttermodule/kline/klineconstrants.dart';

class KlineVolumeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    KlineBloc bloc = KlineBlocProvider.of<KlineBloc>(context);
    return StreamBuilder(
      stream: bloc.currentKlineListStream,
      builder: (BuildContext context, AsyncSnapshot<List<KLineModel>> snapshot) {
        return CustomPaint(
          key: bloc.volumeWidgetKey,
          size: Size(bloc.screenWidth, bloc.screenWidth / kVolumeAspectRatio),
          painter: _KlineVolumePainter(
              snapshot.data, bloc.volumeMax, bloc.candlestickWidth),
        );
      },
    );
  }
}

class _KlineVolumePainter extends CustomPainter {
  final List<KLineModel> listData;
  final double maxVolume;
  _KlineVolumePainter(
      this.listData,
      this.maxVolume,
      this.columnarWidth,
      );
  
  final double columnarWidth;
  final double columnarGap = kColumnarGap;
  final double columnarTopMargin = kColumnarTopMargin;
  final Color increaseColor = kIncreaseColor;
  final Color decreaseColor = kDecreaseColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (listData == null || maxVolume == null || maxVolume == 0) { return; }
    double height = size.height - columnarTopMargin;
    final double heightVolumeOffset = height / maxVolume;
    double columnarRectLeft;
    double columnarRectTop;
    double columnarRectRight;
    double columnarRectBottom;

    Paint columnarPaint;

    for (int i = 0; i < listData.length; i ++) {
      KLineModel klinemodel = listData[i];

      Color painterColor;
      if (double.parse(klinemodel.stock.open) > double.parse(klinemodel.stock.close)) { painterColor = decreaseColor; }
      else if (double.parse(klinemodel.stock.open) == double.parse(klinemodel.stock.close)) { painterColor = Colors.white; }
      else { painterColor = increaseColor; }
      columnarPaint = Paint()
        ..color = painterColor
        ..strokeWidth = columnarWidth
        ..isAntiAlias = true
        ..filterQuality = FilterQuality.high;
      
      int j = listData.length - 1 - i;
      columnarRectLeft = j * (columnarWidth + columnarGap) + columnarGap;
      columnarRectRight = columnarRectLeft + columnarWidth;
      columnarRectTop = height - double.parse(klinemodel.stock.volume) * heightVolumeOffset + columnarTopMargin;
      columnarRectBottom = height + columnarTopMargin;
      Rect columnarRect = Rect.fromLTRB(columnarRectLeft, columnarRectTop, columnarRectRight, columnarRectBottom);
      canvas.drawRect(columnarRect, columnarPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) { return listData != null; }
}