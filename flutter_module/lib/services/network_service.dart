import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttermodule/models/stock.dart';
class NetworkService {
  final String url;

  NetworkService(this.url);
  /**
   * fetching data from url
   */
  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      print(url);
      return decodedData;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<StockList> getDataListFormat() async { // getData method in StockList format,
    // this is useful for the fetchStock method
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return StockList.fromJson(json.decode(response.body));
    }
    else {
      print(response.statusCode);
      return null;
    }
  }

  Future getNasdaq() async { // get the lastest value of the NASDAQ index
    final response = await http.get('https://query1.finance.yahoo.com/v7/finance/chart/^IXIC?&interval=5m'); // No API key needed
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData;
    }
    else {
      print(response.statusCode);
      return null;
    }
  }

  Future getDow() async { // get the lastest value of the Dow Jones
    final response = await http.get('https://query1.finance.yahoo.com/v7/finance/chart/^DWCPF?&interval=5m'); // No API key needed
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData;
    }
    else {
      print(response.statusCode);
      return null;
    }
  }

}
