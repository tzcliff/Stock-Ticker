import 'package:flutter/material.dart';
import 'package:fluttermodule/constants.dart';
import 'package:fluttermodule/screens/martket_screen.dart';
import 'package:fluttermodule/screens/model_screen.dart';
import 'package:fluttermodule/screens/search_stock_screen.dart';
import 'package:fluttermodule/screens/setting_screen.dart';
import 'package:fluttermodule/screens/watchlist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _marketScreen = MarketScreen();
  final _watchlistScreen = WatchlistScreen();
  final _modelScreen = ModelScreen();
  final _settingScreen = SettingScreen();
  int selectedIndex = 0;
  final List<Widget> _pages = [
    MarketScreen(),
    WatchlistScreen(),
    ModelScreen(),
    SettingScreen(),
  ];
  @override
  void initState() {
    print('init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 55,
        height: 55,
        child: FloatingActionButton(
          onPressed: () async {
            var stockSymbol =
                await Navigator.pushNamed(context, SearchStockScreen.id);
          },
          child: Icon(Icons.search),
          elevation: 4.0,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              title: Text(
                'Market',
                style: kBottomBarTextStyle,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.remove_red_eye),
              title: Text(
                'Watchlist',
                style: kBottomBarTextStyle,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.widgets),
              title: Text(
                'Models',
                style: kBottomBarTextStyle,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(
                'Setting',
                style: kBottomBarTextStyle,
              )),
        ],
        currentIndex: selectedIndex,
        onTap: onBottomItemTapped,
        fixedColor: Colors.teal,
      ),
      body: SafeArea(child: _pages[selectedIndex]),
    );
  }

  void onBottomItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
