import 'package:flutter/material.dart';

class InputField2 extends StatelessWidget {
  const InputField2(this.text, this.obscure,this.onChangedCallback);
  final String text;
  final bool obscure;
  final Function onChangedCallback;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      onChanged: (value){
        onChangedCallback(value);
      },
      cursorColor: Color(0xFF13192F),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(color: Color(0xFF13192F)),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF13192F), width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF13192F), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
    );
  }
}
