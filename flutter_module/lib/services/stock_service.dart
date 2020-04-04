import 'dart:collection';

import 'package:fluttermodule/data/stock_search_item_data.dart';
import 'package:fluttermodule/models/stock_search_item.dart';

import 'network_service.dart';
import 'package:fluttermodule/api_keys.dart';

const String alphaStockApiURL = 'https://www.alphavantage.co/query';

class StockService {
  /**
   * Get Stock Quote By Symbol
   */
  Future<dynamic> getStockQuoteBySymbol(String symbol) async {
    NetworkService networkService = NetworkService(
        '$alphaStockApiURL?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$kAlphaStockAPIKey');

    var stockData = await networkService.getData();
    return stockData;
  }

  /**
   * Get Stock Search Suggestions Future by keyword
   */
  Future<dynamic> getStockSearchSuggestionByKeyword(String keyword) async {
    NetworkService networkService = NetworkService(
        '$alphaStockApiURL?function=SYMBOL_SEARCH&keywords=$keyword&apikey=$kAlphaStockAPIKey');
    var searchData = await networkService.getData();
    return searchData;
  }

  /**
   * Get List<StockSearchItem>
   *  */
  Future<List<dynamic>> getStockSearchItems(String keyword) async {
    var searchData = await getStockSearchSuggestionByKeyword(keyword);
    if (searchData != null) {
      List<dynamic> matches = searchData['bestMatches'];
      return matches;
    }
    return null;
  }
}
