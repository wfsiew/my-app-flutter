import 'package:flutter_money_formatter/flutter_money_formatter.dart';

String formatAmt(double a) {
  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
    amount: a,
    settings: MoneyFormatterSettings(symbol: 'RM')
  );
  return fmf.output.symbolOnLeft;
}