import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/task-data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddClassWork extends StatefulWidget {
  static String id = 'add-classwork';
  @override
  State<AddClassWork> createState() => _AddClassWorkState();
}

class _AddClassWorkState extends State<AddClassWork> {
  late String classworkName = "";

  @override
  Widget build(BuildContext context) {
    String code = Provider.of<TaskData>(context).classCode;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.0, color: const Color(0xFF757575)),
        color: const Color(0xFF757575),
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Classwork',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF13192F)),
            ),
            TextField(
              autofocus: true,
              cursorColor: Color(0xFF13192F),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18.0,color: Color(0xFF13192F)),
              onChanged: (value) {
                  classworkName = value;
              },
            ),
            FlatButton(
              color: Color(0xFF13192F),
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                String time = DateFormat.Hms().format(DateTime.now()).toString();
                FirebaseFirestore.instance.collection("classwork-$code").doc(time).set({
                  'classwork' : classworkName,
                  'classworkSerial': time,
                  'classworkTime': DateFormat.yMd().format(DateTime.now()).toString(),
                });
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
