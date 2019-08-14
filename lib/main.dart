import 'package:flutter/material.dart';
//import 'package:toast/toast.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:my_app/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'services.dart';
import 'models.dart';
import 'product-detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder>{
      Cart.routeName: (BuildContext context) => Cart(title: 'Cart',),
      ProductDetail.routeName: (BuildContext context) => ProductDetail(title: 'Product Detail',),
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

  void onTapItem(BuildContext context, Product o) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String carts = pref.getString('carts');
    if (carts == null) {
      var line = new List<CartLine>();
      CartLine x = new CartLine();
      x.product = o;
      x.quantity = 1;
      line.add(x);
      String cartLine = jsonEncode(line);
      pref.setString('carts', cartLine);
    }

    else {
      var ls = jsonDecode(carts);
      List<CartLine> line = ls.map<CartLine>((x) => CartLine.fromJson(x)).toList();
      print('======');
      print(carts);
      CartLine k = line.firstWhere((x) => x.product.productID == o.productID, orElse: () => null);
      print(k);
      if (k == null) {
        k = new CartLine();
        k.product = o;
        k.quantity = 1;
        line.add(k);
      }

      else {
        k.quantity += 1;
      }

      String cartLine = jsonEncode(line);
      pref.setString('carts', cartLine);
    }

    Navigator.pushNamed(context, Cart.routeName);

    // Navigator.pushNamed(context, ProductDetail.routeName, arguments: ProductArgs(
    //   o.productID, o.name
    // ));
    //Toast.show(x, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

  Future<void> refreshData() async {
    getProducts();
  }

  String formatAmt(double a) {
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
      amount: a,
      settings: MoneyFormatterSettings(symbol: 'RM')
    );
    return fmf.output.symbolOnLeft;
  }

  Widget listViewWidget(List<Product> lx) {
    return Container(
      child: ListView.builder(
        itemCount: lx.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, position) {
          return Card(
            child: ListTile(
              title: Text(
                '${lx[position].name}',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black
                )
              ),
              subtitle: Text('${lx[position].description}'),
              leading: IconButton(
                icon: Icon(Icons.add, size: 24.0, color: Colors.blueAccent),
                onPressed: () {
                  Product o = lx[position];
                  onTapItem(context, o);
                },
              ),
              trailing: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Text('${formatAmt(lx[position].price)}')
                ),
              ),
            )
          );
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: FutureBuilder(
          future: getProducts(),
          builder: (context, snapshot) {
            return snapshot.data != null
              ? listViewWidget(snapshot.data)
              : Center(child: CircularProgressIndicator());
          },
        ),
      ),
      // body: RefreshIndicator(
      //   child: FutureBuilder(
      //     future: getCategories(),
      //     builder: (context, snapshot) {
      //       return snapshot.data != null
      //         ? listViewWidget(snapshot.data)
      //         : Center(child: CircularProgressIndicator());
      //     },
      //   ),
      //   onRefresh: refreshData,
      // )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
