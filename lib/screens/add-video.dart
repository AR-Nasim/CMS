import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/task-data.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class AddVideo extends StatefulWidget {
  static String id = 'add-video';

  @override
  _AddVideoState createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  List<File> _video = [];
  final picker = ImagePicker();
  late VideoPlayerController _videoPlayerController;

  late CollectionReference videoRef;
  late Reference ref;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Videos'),
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
          itemCount: _video.length + 1,
          itemBuilder: (context, index) {
            if(index >0)
            _videoPlayerController = VideoPlayerController.file(_video[index-1])..initialize().then((value) {
              setState(() {

              });
              _videoPlayerController.play();
            });
            return index == 0
                ? Center(
              child: IconButton(
                  icon: Icon(Icons.video_call_outlined), onPressed: selectFiles),
            )
                : Container(
              margin: EdgeInsets.all(3.0),
              child: AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              ),
            );
          },
        ),
      ),);
  }

  // selectFiles() async {
  //   FilePickerResult? result = (await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.video));
  //   if (result == null) return;
  //   List<PlatformFile> files = result.files;
  //   files.forEach((element) {
  //     setState(() {
  //       _video.add(File(element.path!));
  //     });
  //   });
  // }
  selectFiles() async {
    final pickedImage = await picker.getVideo(source: ImageSource.gallery);
    setState(() {
      _video.add(File(pickedImage!.path));
    });
  }

  Future uploadFile()async{
    String email = Provider.of<TaskData>(context, listen: false).userEmail;
    String code = Provider.of<TaskData>(context, listen: false).courseCode;
    String batch = Provider.of<TaskData>(context, listen: false).courseBatch;
    for(var video in _video){
      String newFileName = video.path.toString().split('/').last;
      ref = FirebaseStorage.instance.ref().child('videoResources/$email/$code-$batch/$newFileName');
      await ref.putFile(video).whenComplete(()async{
        await ref.getDownloadURL().then((value){
          videoRef.add({'url': value,'email':email, 'courseCode':code, 'courseBatch': batch});
        }
        );
      });
    }
  }

  @override
  void initState(){
    super.initState();
    videoRef = FirebaseFirestore.instance.collection('videoURLs');
  }
}


