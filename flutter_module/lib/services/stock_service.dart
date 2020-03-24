import 'network_service.dart';
import 'package:fluttermodule/constants.dart';

const String alphaStockApiURL = 'https://www.alphavantage.co/query';

class StockService {
  Future<dynamic> getStockBySymbol(String symbol) async {
    NetworkService networkService = NetworkService(
        '$alphaStockApiURL?function=TIME_SERIES_DAILY&symbol=$symbol&outputsize=compact&apikey=$kAlphaStockAPIKey');

    var stockData = await networkService.getData();
    return stockData;
  }
}
