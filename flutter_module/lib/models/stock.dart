class Stock {
  final String date;
  final String open;
  final String high;
  final String low;
  final String close;
  final String volume;

  Stock({this.date, this.open, this.high, this.low, this.close, this.volume});

  String getData(String type) {
    if (type == 'date') {
      return date;
    }

    if (type == 'open') {
      return open;
    }

    if (type == 'high') {
      return high;
    }
    if (type == 'low') {
      return low;
    }
    if (type == 'close') {
      return close;
    }
    if (type == 'volume') {
      return volume;
    }
  }

  @override
  String toString() {
    return 'Date: ' +
        this.date +
        ' Open: ' +
        this.open +
        ' High: ' +
        this.high +
        ' Low: ' +
        this.low +
        ' Close: ' +
        this.close +
        ' Volume: ' +
        this.volume;
  }
}

class StockList {
  // this object is just a list of stocks
  final List<Stock> list;

//  List list () {
//    return _list;
//  }

  StockList(this.list);



  factory StockList.fromJson(Map<String, dynamic> json) {
    // parse the json into data we can use it
    if (json['Time Series (Daily)'] == null) {
      throw Exception(
          "An error has occured. Are you sure you entered a valid stock ticker?");
    }
    int size = json['Time Series (Daily)'].keys.toList().length;

    List<Stock> stockList = [];

    for (int i = 0; i < size; i++) {
      stockList.add(new Stock(
        date: json['Time Series (Daily)'].keys.toList()[i],
        open: json['Time Series (Daily)'].values.toList()[i]['1. open'],
        high: json['Time Series (Daily)'].values.toList()[i]['2. high'],
        low: json['Time Series (Daily)'].values.toList()[i]['3. low'],
        close: json['Time Series (Daily)'].values.toList()[i]['4. close'],
        volume: json['Time Series (Daily)'].values.toList()[i]['5. volume'],
      ));
    }


    return StockList(
      stockList,
    );
  }

//  @override
//  String toString() {
//    String ret = "";
//    for (int i = 0; i < this.list.length; i++) { // iterate over the StockList
//      ret += list[i] + "; ";
//    }
//    return ret;
//  }

}
