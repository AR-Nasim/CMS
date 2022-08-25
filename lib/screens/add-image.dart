import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/task-data.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddImage extends StatefulWidget {
  static String id = 'add-image';

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  List<File> _image = [];
  final picker = ImagePicker();

  late CollectionReference imgRef;
  late Reference ref;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Images'),
        backgroundColor: Color(0xFF13192F),
        actions: [
          FlatButton(
            onPressed: (){
              uploadFile();
              Navigator.pop(context);
            },
            child: Text('Upload',style: TextStyle(color: Colors.white),),

          )
        ],
      ),
        body: ColorfulSafeArea(
          color: Color(0xFF13192F),
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: _image.length + 1,
            itemBuilder: (context, index) {
              return index == 0
                  ? Center(
                      child: IconButton(
                          icon: Icon(Icons.add_a_photo_outlined), onPressed: selectFiles),
                    )
                  : Container(
                      margin: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(_image[index - 1]),
                              fit: BoxFit.cover)),
                    );
            },
          ),
        ),);
  }

  selectFiles() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedImage!.path));
    });
  }

  Future uploadFile()async{
    String email = Provider.of<TaskData>(context, listen: false).userEmail;
    String code = Provider.of<TaskData>(context, listen: false).courseCode;
    String batch = Provider.of<TaskData>(context, listen: false).courseBatch;
    for(var img in _image){
      String newFileName = img.path.toString().split('/').last;
      ref = FirebaseStorage.instance.ref().child('imageResources/$newFileName');
      await ref.putFile(img).whenComplete(()async{
        await ref.getDownloadURL().then((value){
          imgRef.add({'url': value,'email':email, 'courseCode':code, 'courseBatch': batch});
        }
        );
      });
    }
  }

  @override
  void initState(){
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }
}
