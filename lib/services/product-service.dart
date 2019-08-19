import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:my_app/models/product.dart';
import 'package:my_app/constants.dart';

final String url = '${Constants.PRODUCT_URL}';

Future<List<String>> getCategories() async {
  List<String> lx;
  var res = await http.get(
    '$url/categories',
    headers: { HttpHeaders.acceptHeader: "application/json" }
  );

  if (res.statusCode == 200) {
    String resbody = res.body;
    var data = jsonDecode(resbody);

    var ls = data as List;
    lx = new List<String>.from(ls);
  }

  return lx;
}

Future<List<Product>> getProducts([String category, int page = 1]) async {
  List<Product> lx;
  var res;
  if (category == null) {
    res = await http.get(
      '$url/$page',
      headers: { HttpHeaders.acceptHeader: "application/json" }
    );
  }

  else {
    res = await http.get(
      '$url/$category/$page',
      headers: { HttpHeaders.acceptHeader: "application/json" }
    );
  }

  if (res.statusCode == 200) {
    String resbody = res.body;
    var data = jsonDecode(resbody);

    var ls = data['products'] as List;
    lx = ls.map<Product>((x) => Product.fromJson(x)).toList();
  }

  return lx;
}