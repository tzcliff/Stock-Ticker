import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermodule/services/kline_bloc_service.dart';
import 'package:fluttermodule/services/kline_bloc_provider_service.dart';

class KlineLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    KlineBloc bloc = KlineBlocProvider.of<KlineBloc>(context);
    return StreamBuilder(
      stream: bloc.klineShowLoadingStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool show = snapshot.data == null ? true : snapshot.data;
        return Container( child: Center(child: show ? CupertinoActivityIndicator() : null));
      },
    );
  }
}