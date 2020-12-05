import 'package:flutter/material.dart';
import 'package:wordpress_app/screens/basePage.dart';
import 'package:wordpress_app/screens/cart_page.dart';
import 'dashboardPage.dart';

class HomePage extends BasePage {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> {
  List<Widget> _widgetList = [
    DashboardPage(),
    CartPage(),
    DashboardPage(),
    DashboardPage(),
  ];

  int _index = 0;
  @override
  Widget pageUI() {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_shopping_cart_outlined,
            ),
            label: 'My Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box_outlined,
            ),
            label: 'My Account',
          ),
        ],
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      body: _widgetList[_index],
    );
  }
}
