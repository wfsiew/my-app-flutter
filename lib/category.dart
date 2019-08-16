import 'package:flutter/material.dart';
import 'dart:async';
import 'services.dart';

class Category extends StatefulWidget {
  Category({Key key, this.title}) : super(key: key);

  static const String routeName = '/Category';

  final String title;

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  Future<void> refreshData() async {
    await getCategories();
  }

  Widget buildRow(String s) {
    return Card(
      child: ListTile(
        title: Text(
          '$s',
          style: TextStyle(
            fontSize: 18.0
          ),
        ),
        onTap: () {
          Navigator.pop(context, s);
        },
      ),
    );
  }

  Widget buildList(List<String> ls) {
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.all(2.0),
        itemCount: ls.length,
        itemBuilder: (context, i) {
          return buildRow(ls[i]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: FutureBuilder(
          future: getCategories(),
          builder: (context, snapshot) {
            return snapshot.data != null
              ? buildList(snapshot.data)
              : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}