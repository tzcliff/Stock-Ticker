enum StockItem {
  high,
  low,
  open,
  close,
}

extension on StockItem {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

enum Trend {
  increase,
  decrease,
}

extension on Trend {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

enum UserAction {
  buy,
  sell,
}

extension on UserAction {
  String toShortString() {
    return this.toString().split('.').last;
  }
}


