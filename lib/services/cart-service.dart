import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/models/cart.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/constants.dart';

final String url = '${Constants.ORDER_URL}';

Future<List<CartLine>> getLines() async {
  List<CartLine> ls;
  SharedPreferences pref = await SharedPreferences.getInstance();
  String carts = pref.getString('carts');
  if (carts == null) {
    ls = <CartLine>[];
  }

  else {
    var lx = jsonDecode(carts);
    ls = lx.map<CartLine>((x) => CartLine.fromJson(x)).toList();
  }

  return ls;
}

Future<void> addItem(Product product, int quantity) async {
  List<CartLine> lines = await getLines();
  CartLine line = lines.firstWhere((x) => x.product.productID == product.productID, orElse: () => null);
  if (line == null) {
    var o = new CartLine();
    o.product = product;
    o.quantity = quantity;
    lines.add(o);
  }

  else {
    line.quantity += quantity;
  }

  await saveCart(lines);
}

Future<void> saveCart(List<CartLine> lines) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (lines.isEmpty) {
    await pref.remove('carts');
  }

  else {
    String s = jsonEncode(lines);
    await pref.setString('carts', s);
  }
}

Future<void> removeItem(Product product) async {
  List<CartLine> lines = await getLines();
  lines.removeWhere((x) => x.product.productID == product.productID);
  await saveCart(lines);
}

Future<void> updateItem(int productID, int quantity) async {
  List<CartLine> lines = await getLines();
  CartLine line = lines.firstWhere((x) => x.product.productID == productID, orElse: () => null);
  if (line != null) {
    line.quantity = quantity;
    await saveCart(lines);
  }
}

Future<bool> checkout(String s) async {
  bool b = false;
  var res = await http.post(
    '$url/checkout',
    headers: { HttpHeaders.contentTypeHeader: "application/json" },
    body: s
  );

  if (res.statusCode == 200) {
    await clear();
    b = true;
  }

  return b;
}

Future<void> clear() async {
  await saveCart(new List<CartLine>());
}