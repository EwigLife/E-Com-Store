import 'package:flutter/material.dart';
import 'dashboardPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Widget> _widgetList = [
    DashboardPage(),
    DashboardPage(),
    DashboardPage(),
    DashboardPage(),
  ];

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
        bottomNavigationBar: 
        BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,),
          label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart_outlined,),
          label: 'My Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined),
          label: 'Favourites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.account_box_outlined,),
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

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: Colors.redAccent,
      automaticallyImplyLeading: false,
      title: Text(
        'My APP',
        style: TextStyle(color: Colors.white,),
      ),
      actions: [
        Icon(Icons.notifications_none, color: Colors.white,),
        SizedBox(width: 10,),
        Icon(Icons.shopping_cart, color: Colors.white,),
        SizedBox(width: 10,),
      ],
    );
  }
}