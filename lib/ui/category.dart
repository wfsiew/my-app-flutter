import 'package:flutter/material.dart';
import 'dart:async';
import 'package:my_app/services/product-service.dart';
import 'package:my_app/shared/widgets/show-error.dart';

class Category extends StatefulWidget {
  Category({Key key, this.title}) : super(key: key);

  static const String routeName = '/Category';

  final String title;

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Future<List<String>> ls;

  @override
  void initState() {
    super.initState();
    ls = loadData();
  }

  Future<List<String>> loadData() async {
    return await getCategories();
  }

  Future<void> refreshData() async {
    await getCategories();
  }

  Widget buildSnapshot(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return ShowError(
          error: snapshot.error,
          onRetry: () {
            setState(() {
             ls = loadData(); 
            });
          },
        );
      }

      return buildList(snapshot.data);
    }

    else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
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
          future: ls,
          builder: (context, snapshot) {
            return buildSnapshot(context, snapshot);
          },
        ),
      ),
    );
  }
}