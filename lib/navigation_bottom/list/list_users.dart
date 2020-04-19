import 'package:flutter/material.dart';

class ListUsers extends StatefulWidget {
  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'filtro',
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: Text('filtro dois'),
              floating: true,
              expandedHeight: 100,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  child: Column(
                    children: <Widget>[
                      Text('aaaaaaaaaaaaaaaaaaa #$index'),
                    ],
                    ),
                  ),
                childCount: 99,
              )
            )
          ],
        ),
      ),
    );
  }
}