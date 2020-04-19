import 'package:flutter/material.dart';
import 'package:future/navigation_bottom/list/list_users.dart';

class MainPage extends StatefulWidget {

  final user;

  MainPage({
    Key key,
    @required this.user
  }): super(key: key);

  

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectedPage = 0;
  final _pages = [
    Text('Home'),
    ListUsers(),
    Text('Settings'),
    Text('Exit'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: _pages[_selectedPage],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title:Text('Home'),
              backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title:Text('List'),
              backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title:Text('Settings'),
              backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app),
              title:Text('Exit'),
              backgroundColor: Colors.black
            )
          ],
          currentIndex: _selectedPage,
          onTap: (int index){
            _changePage(index);
          },
        ),
      ),
    );
  }

  void _changePage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}