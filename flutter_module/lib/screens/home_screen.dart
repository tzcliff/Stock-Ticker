import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttermodule/constants.dart';
import 'package:fluttermodule/screens/martket_screen.dart';
import 'package:fluttermodule/screens/model_screen.dart';
import 'package:fluttermodule/screens/search_stock_screen.dart';
import 'package:fluttermodule/screens/setting_screen.dart';
import 'package:fluttermodule/screens/watchlist_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  static String uid = '';
  static String email = '';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  bool showSpinner = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  final List<Widget> _pages = [
    MarketScreen(),
    WatchlistScreen(),
    ModelScreen(),
    SettingScreen(),
  ];

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          showSpinner = false;
        });

        loggedInUser = user;
        HomeScreen.uid = loggedInUser.uid;
        HomeScreen.email = loggedInUser.email;
        print(user.uid);
      }
    } catch (e) {}
  }

  @override
  void initState() {
    showSpinner = true;
    getCurrentUser();
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
      body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(child: _pages[selectedIndex])),
    );
  }

  void onBottomItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
