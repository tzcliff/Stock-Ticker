import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermodule/services/kline_bloc_service.dart';
import 'package:fluttermodule/services/kline_bloc_provider_service.dart';
import 'package:fluttermodule/kline/klineconstrants.dart';
import 'package:fluttermodule/kline/klinemodel.dart';
import 'package:fluttermodule/components/klinewidget.dart';
import 'package:fluttermodule/screens/stock_info_screen.dart';

class KlinePageWidget extends StatelessWidget {
  final KlineBloc bloc;
  KlinePageWidget(this.bloc);
  @override
  Widget build(BuildContext context) {
    Offset lastPoint;
    bool isScale = false;
    bool isLongPress = false;
    bool isHorizontalDrag = false;
    double screenWidth = MediaQuery.of(context).size.width;
    _showCrossWidget(Offset offset) {
      if (isScale || isHorizontalDrag) { return; }
      isLongPress = true;
      int singleScreenCandleCount = bloc.getSingleScreenCandleCount(screenWidth);
      int offsetCount = ((offset.dx / screenWidth) * singleScreenCandleCount).toInt();
      if (offsetCount > bloc.klineCurrentList.length - 1) { return; }
      int index = bloc.klineCurrentList.length - 1 - offsetCount;

      if (index < bloc.klineCurrentList.length) {
        KLineModel klinemodel = bloc.klineCurrentList[index];
        klinemodel.isShowCandleInfo = true;
        RenderBox candleWidgetRenderBox = bloc.candleWidgetKey.currentContext.findRenderObject();
        Offset candleWidgetOriginOffset = candleWidgetRenderBox.localToGlobal(Offset.zero);

        RenderBox currentWidgetRenderBox = context.findRenderObject();
        Offset currentWidgetOriginOffset = currentWidgetRenderBox.localToGlobal(Offset.zero);

        RenderBox volumeWidgetRenderBox = bloc.volumeWidgetKey.currentContext.findRenderObject();

        klinemodel.candleWidgetOriginY = candleWidgetOriginOffset.dy - currentWidgetOriginOffset.dy;
        klinemodel.gridTotalHeight = candleWidgetRenderBox.size.height + volumeWidgetRenderBox.size.height;
        bloc.marketSinkAdd(klinemodel);
      }
    }

    _hiddenCrossWidget() {
      isLongPress = false;
      bloc.marketSinkAdd(KLineModel(null, isShowCandleInfo: false));
    }

    _horizontalDrag(Offset offset) {
      if (isScale || isLongPress) { return; }
      isHorizontalDrag = true;
      double offsetX = offset.dx - lastPoint.dx;
      int singleScreenCandleCount = bloc.getSingleScreenCandleCount(screenWidth);

      int offsetCount = ((offsetX / screenWidth) * singleScreenCandleCount).toInt();
      if (offsetCount == 0) { return; }
      int firstScreenNum = (singleScreenCandleCount * bloc.getFirstScreenScale()).toInt();
      if (bloc.klineTotalList.length > firstScreenNum) {
        int currentOffsetCount = bloc.toIndex + offsetCount;
        int totalListLength = bloc.klineTotalList.length;
        currentOffsetCount = min(currentOffsetCount, totalListLength);
        if (currentOffsetCount < firstScreenNum) { return; }
        int fromIndex = 0;

        if (currentOffsetCount > singleScreenCandleCount) { fromIndex = (currentOffsetCount - singleScreenCandleCount); }
        lastPoint = offset;
      }
    }

    _scaleUpdate(double scale) {
      if (isHorizontalDrag || isLongPress) { return; }
      isScale = true;
      if (scale > 1 && (scale - 1) > 0.03) { scale = 1.03; }
      else if (scale < 1 && (1 - scale) > 0.03) { scale = 0.97; }
      double candlestickWidth = scale * bloc.candlestickWidth;
      bloc.setCandlestickWidth(candlestickWidth);
      double count = (screenWidth - bloc.candlestickWidth) / (kCandlestickGap + bloc.candlestickWidth);
      int currentScreenCountNum = count.toInt();

      int toIndex = bloc.toIndex;
      int fromIndex = toIndex - currentScreenCountNum;
      fromIndex = max(0, fromIndex);
      
      bloc.getSubKlineList(fromIndex, toIndex);
    }

    return KlineBlocProvider<KlineBloc>(
      bloc: bloc,
      child: GestureDetector(
        onTap: () {
          if (isLongPress) {
            _hiddenCrossWidget();
          }
        },

        onLongPressStart: (longPressDragStartDetail) {
          _showCrossWidget(longPressDragStartDetail.globalPosition);
        },
        onLongPressMoveUpdate: (longPressDragUpdateDetail) {
          _showCrossWidget(longPressDragUpdateDetail.globalPosition);
        },
        
        onHorizontalDragDown: (horizontalDragDown) {
          if (isLongPress) {
            _hiddenCrossWidget();
          }
          lastPoint = horizontalDragDown.globalPosition;
        },
        onHorizontalDragUpdate: (details) {
          _horizontalDrag(details.globalPosition);
        },
        onHorizontalDragEnd: (_) {
          isHorizontalDrag = false;
        },
        onHorizontalDragCancel: () {
          isHorizontalDrag = false;
        },
        onScaleStart: (_) {
          isScale = true;
        },
        
        onScaleUpdate: (details) {
          if (isLongPress) {
            _hiddenCrossWidget();
          }
          _scaleUpdate(details.scale);
        },
        onScaleEnd: (_) {
          isScale = false;
        },

        child: StreamBuilder(
          stream: bloc.klineListStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<KLineModel>> snapshot) {
            List<KLineModel> listData = snapshot.data;
            if (listData != null) {
              bloc.setScreenWidth(screenWidth);
            }
            return KLineWidget();
          },
        ),
      ),
    );
  }
}