import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'pages/explore.dart';
import 'pages/cart.dart';
import 'pages/profile.dart';
import 'pages/search.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget splash = SplashScreenView(
      navigateRoute: HomePage(),
      duration: 5000,
      imageSize: 130,
      imageSrc: "assets/images/logo-splash.jpeg",
      text: "TRILY",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
      colors: [
        Colors.black,
        Colors.blue.shade100,
        Colors.black,
      ],
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _selectedPage = 0;

  List<Widget> pages = [
    ExplorePage(),
    SearchPage(),
    CartPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) => setState(() { _selectedPage = index; }),
        controller: _pageController,
        children: [
          ...pages
        ],
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedPage,
        showElevation: false,
        onItemSelected: (index) => _onItemTapped(index),
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.home_outlined, size: 23),
            title: Text('Home'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.search, size: 23),
            title: Text('Cari'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.shopping_bag_outlined, size: 23),
            title: Text('Keranjang'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.account_circle_outlined, size: 23,),
            title: Text('Akun'),
          ),
        ],
      ),
    );
  }
}
