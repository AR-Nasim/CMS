import 'package:flutter/material.dart';

class ErrorMessage extends StatefulWidget {
  ErrorMessage(this.error);
  late String error='';

  @override
  _ErrorMessageState createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<ErrorMessage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.error,
          style: TextStyle(
            //height: widget.error=='' ? 0.0 : 2.0,
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: widget.error=='' ? 0.0 : 16.0,
          ),
        ),
        SizedBox(
          height: widget.error=='' ? 0.0 : 10.0,
        ),
      ],
    );
  }
}
