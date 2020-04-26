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

}
