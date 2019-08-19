import 'package:my_app/validators/general.dart';

String vName(String s) {
  var v = vRequired(s, 'Name');
  if (v == null) {
    v = vMin(s, 3, 'Name');
  }

  return v;
}