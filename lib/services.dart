import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'models.dart';

String url = 'http://192.168.0.136:5000/api/product';

Future<List<String>> getCategories() async {
  List<String> lx;
  var res = await http.get(
    '$url/categories',
    headers: { "Accept": "application/json" }
  );

  if (res.statusCode == 200) {
    String resbody = res.body;
    //print(res.body);
    var data = json.decode(resbody);
    //print(data);

    var ls = data as List;
    lx = new List<String>.from(ls);
  }

  else {
    //print('${res.statusCode}');
  }

  return lx;
}

Future<List<Product>> getProducts() async {
  List<Product> lx;
  var res = await http.get(
    '$url/1',
    headers: { "Accept": "application/json" }
  );

  if (res.statusCode == 200) {
    String resbody = res.body;
    //print(resbody);
    var data = json.decode(resbody);
    //print(data);

    var ls = data['products'] as List;
    lx = ls.map<Product>((x) => Product.fromJson(x)).toList();
  }

  return lx;
}