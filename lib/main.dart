import 'package:flutter/material.dart';
//import 'package:toast/toast.dart';
import 'package:my_app/ui/home.dart';
import 'package:my_app/ui/cart.dart';
import 'package:my_app/ui/category.dart';
import 'package:my_app/ui/checkout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder>{
      Home.routeName: (BuildContext context) => Home(title: "My Store"),
      Cart.routeName: (BuildContext context) => Cart(title: 'My Cart'),
      Category.routeName: (BuildContext context) => Category(title: 'Categories'),
      Checkout.routeName: (BuildContext context) => Checkout(title: 'Check out'),
    };

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<bool> willPop() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(''),
          content: Text('Are you sure you want to close application?'),
          actions: <Widget>[
            FlatButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('YES'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      }
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WillPopScope(
      onWillPop: willPop,
      child: Home(title: 'Flutter Demo Home Page'),
    );
  }
}
