import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'models.dart';
import 'constants.dart';

final String url = '${Constants.SERVER}/api/product';

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

Future<List<Product>> getProducts([String category, int page = 1]) async {
  List<Product> lx;
  var res;
  if (category == null) {
    res = await http.get(
      '$url/$page',
      headers: { "Accept": "application/json" }
    );
  }

  else {
    res = await http.get(
      '$url/$category/$page',
      headers: { "Accept": "application/json" }
    );
  }

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