import 'dart:collection';
import 'dart:convert';
import 'package:fluttermodule/data/stock_search_item_data.dart';

import 'network_service.dart';
import 'package:fluttermodule/api_keys.dart';
import 'package:fluttermodule/models/stock.dart';

const String alphaStockApiURL = 'https://www.alphavantage.co/query';

class StockService {
  /// Get Stock Quote By Symbol
  Future<dynamic> getStockQuoteBySymbol(String symbol) async {
    NetworkService networkService = NetworkService(
        '$alphaStockApiURL?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$kAlphaStockAPIKey');

    var stockData = await networkService.getData();
    return stockData;
  }

  /// Get Stock Search Suggestions Future by keyword
  Future<dynamic> getStockSearchSuggestionByKeyword(String keyword) async {
    NetworkService networkService = NetworkService(
        '$alphaStockApiURL?function=SYMBOL_SEARCH&keywords=$keyword&apikey=$kAlphaStockAPIKey');
    var searchData = await networkService.getData();
    return searchData;
  }

  /// Get List<StockSearchItem>
  ///  */
  Future<List<dynamic>> getStockSearchItems(String keyword) async {
    var searchData = await getStockSearchSuggestionByKeyword(keyword);
    if (searchData != null) {
      List<dynamic> matches = searchData['bestMatches'];
      return matches;
    }
    return null;
  }

  Future<StockList> fetchStock(String symbol) async {
    // a future is a Dart class for async operations, a future represents a potential value OR error that will be available at some future time
    NetworkService networkService = NetworkService(
        'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=' +
            symbol +
            '&apikey=' +
            kAlphaStockAPIKey);

    var data = await networkService.getDataListFormat();
    if (data != null) {
      // double check the data one last time
      return data;
      // return StockList.fromJson(json.decode(response.body));
    } else {
      // If the data isn't there for some reason (i.e. not a 200 response code)
      throw Exception('Failed to load stock');
    }
  }
}
