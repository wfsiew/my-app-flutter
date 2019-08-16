import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';

Future<List<CartLine>> getLines() async {
  List<CartLine> ls;
  SharedPreferences pref = await SharedPreferences.getInstance();
  String carts = pref.getString('carts');
  if (carts == null || carts == '[null]') {
    ls = <CartLine>[];
  }

  else {
    var lx = jsonDecode(carts);
    ls = lx.map<CartLine>((x) => CartLine.fromJson(x)).toList();
  }

  return ls;
}

void addItem(Product product, int quantity) async {
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

  saveCart(lines);
}

void saveCart(List<CartLine> lines) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (lines.isEmpty) {
    await pref.remove('carts');
  }

  else {
    String s = jsonEncode(lines);
    await pref.setString('carts', s);
  }
}

void removeItem(Product product) async {
  List<CartLine> lines = await getLines();
  lines.removeWhere((x) => x.product.productID == product.productID);
  saveCart(lines);
}

void clear() async {
  saveCart(new List<CartLine>());
}