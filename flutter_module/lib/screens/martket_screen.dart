import 'package:flutter/material.dart';
import 'package:fluttermodule/api_keys.dart';
import 'package:fluttermodule/components/index_item.dart';
import 'package:fluttermodule/services/network_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttermodule/components/NewsListItem.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MarketScreen extends StatefulWidget {
  static String id = 'market_screen';
  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  bool showSpinner = false;
  Future nasdaq;
  Future dowJones;
  var nasVal;
  var dowVal;
  List<Widget> newsList = [
    new RaisedButton(
      onPressed: _launchURL,
      child: Text(
        "Powered by News API",
        style: new TextStyle(decoration: TextDecoration.underline),
      ),
    )
  ];

  @override
  void initState() {
    showSpinner = false;
    getMarketVals();
    getNews();

    super.initState();
  }

  void getNews() async {
    var url = 'http://newsapi.org/v2/everything?q=stockmarket&from=';
    var now = new DateTime.now(); // current date
    var year = now.year;
    var month = now.month;
    var then = new DateTime(year, month, 1); // get the first day of this month
    var firstOfMonth = then
        .toString()
        .split(" "); // split so we get easy access to date without time
    url += firstOfMonth[0]; // format date like 2020-03-10
    url += '&sortBy=publishedAt&apiKey=';
    url += newsAPI; // add API key

    NetworkService networkService = new NetworkService(url);
    try {
      dynamic news = networkService.getData();
      var newsData = [];
      if (news != null) {
        news.then((value) {
          newsData = value["articles"].toList(); // api articles in list format
          if (newsData != null) {
            setState(() {
              updateNewsUI(newsData);
            });
          }
        });
      } else {}
    } catch (Exception) {}
  }

  void getMarketVals() async {
    NetworkService networkService1 = new NetworkService(
        "https://query1.finance.yahoo.com/v7/finance/chart/^DWCPF?&interval=5m");
    NetworkService networkService2 = new NetworkService(
        "https://query1.finance.yahoo.com/v7/finance/chart/^IXIC?&interval=5m");
    var dowData;
    var nasdaqData;
    dowJones = networkService1.getData();
    dowJones.then((value) {
      dowData = value;
      nasdaq = networkService2.getData();
      nasdaq.then((value) {
        nasdaqData = value;
        updateUI(dowData, nasdaqData);
      });
    });
  }

  void updateNewsUI(dynamic newsData) {
    for (int x = 0; x < 10; x++) {
      // get the first 10 articles
      var title = newsData[x]["title"];
      var link = newsData[x]["url"];
      var image = newsData[x]["urlToImage"];
      newsList.add(new NewsListItem(title: title, link: link, image: image));
    } // source for our news
  }

  void updateUI(dynamic dowData, dynamic nasdaqData) {
    setState(() {
      if (dowData == null) {
        dowVal = 0.0;
        return;
      }
      try {
        var results = dowData["chart"]["result"][0]["indicators"]["quote"][0]
            ["high"][0]; // raw data
        dowVal = results.toStringAsFixed(2);
      } catch (e) {
        print(e);
        dowVal = 0.0;
      }

      if (nasdaqData == null) {
        nasVal = "error1";
        return;
      }
      try {
        var results = nasdaqData["chart"]["result"][0]["indicators"]["quote"][0]
            ["high"][0]; // raw data
        nasVal = results.toStringAsFixed(2);
      } catch (e) {
        print(e);
        nasVal = "error3";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  IndexItem(
                    symbol: 'Dow Jones',
                    price: dowVal,
                  ),
                  IndexItem(
                    symbol: 'Nasdaq',
                    price: nasVal,
                  )
                ],
              ),
            ),
            Expanded(
                child: Center(
              child: ListView(
                children: newsList,
              ),
            )),
          ],
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://newsapi.org';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
