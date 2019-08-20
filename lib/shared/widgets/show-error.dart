import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ShowError extends StatelessWidget {
  ShowError({Key key, this.error, this.onRetry}) : super(key: key);

  final DioError error;
  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    String msg = error.message;
    if (error.type == DioErrorType.CONNECT_TIMEOUT) {
      msg = 'Connection Timeout';
    }

    else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
      msg = 'Receive Timeout';
    }

    else if (error.type == DioErrorType.RESPONSE) {
      msg = '${error.response.statusCode}';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Error: $msg'),
          RaisedButton(
            elevation: 5,
            child: Text('Retry'),
            onPressed: onRetry,
          ),
        ],
      )
    );
  }
}