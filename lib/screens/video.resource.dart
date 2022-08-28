import 'dart:convert';
import 'dart:io';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/custom-drawer.dart';
import 'package:cms/components/navigation.dart';
import 'package:cms/components/task-data.dart';
import 'package:cms/screens/add-group.dart';
import 'package:cms/screens/add-image.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'add-video.dart';

class VideoResources extends StatefulWidget {
  static String id = 'video-resources';

  @override
  _VideoResourcesState createState() => _VideoResourcesState();
}

class _VideoResourcesState extends State<VideoResources> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  List<String> videoRef = [];
  late VideoPlayerController _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    String email = Provider.of<TaskData>(context, listen: false).userEmail;
    String code = Provider.of<TaskData>(context, listen: false).courseCode;
    String batch = Provider.of<TaskData>(context, listen: false).courseBatch;
    return Scaffold(
        key: _globalKey,
        drawer: CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF13192F),
          onPressed: () {
            Navigator.pushNamed(context, AddVideo.id);
          },
          child: Icon(Icons.upload_rounded),
        ),
        body: ColorfulSafeArea(
            color: Color(0xFF13192F),
            child: Column(
              children: [
                CustomNavigation("Videos",(value) {
                  _globalKey.currentState?.openDrawer();
                }),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('videoURLs').where('courseCode', isEqualTo:code).where('courseBatch', isEqualTo: batch)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ?Center(
                      child: SpinKitDoubleBounce(
                        color: Color(0xFF13192F),
                        size: 50.0,
                      ),
                    )
                        : Container(
                        padding: EdgeInsets.all(4.0),
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data?.docs.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              final data = snapshot.data!.docs[index];
                              _videoPlayerController = VideoPlayerController.network(data['url'])..initialize().then((value) {
                                    _videoPlayerController.play();
                              });
                              return Container(
                                margin: EdgeInsets.all(3.0),
                                child: AspectRatio(
                                  aspectRatio: _videoPlayerController.value.aspectRatio,
                                  child: VideoPlayer(
                                    _videoPlayerController
                                  ),
                                )
                              );
                            }));
                  },
                )

                // FutureBuilder(
                //    future: listFiles(),
                //   builder: (BuildContext context, AsyncSnapshot<ListResult> snapshot){
                //      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                //        return Container(
                //          // child: ListView.builder(
                //          //     shrinkWrap: true,
                //          //   itemCount: snapshot.data!.items.length,
                //          //     itemBuilder: (BuildContext context, int index){
                //          //       Future<String> link = downloadURL(snapshot.data!.items[index].name) ;
                //          //          return Container(
                //          //            child: Text(link.toString()),
                //          //            //Text(,style: TextStyle(color: Colors.black)),
                //          //          );
                //          //     }
                //          // ),
                //        );
                //      }
                //      if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
                //        return CircularProgressIndicator();
                //      }
                //      return Container();
                //   },
                // )
              ],
            )));
  }

// Future<String> downloadURL(imageName) async{
//   print('ba;');
//   String email = Provider.of<TaskData>(context, listen: false).userEmail;
//   String code = Provider.of<TaskData>(context, listen: false).courseCode;
//   String batch = Provider.of<TaskData>(context, listen: false).courseBatch;
//   print('url;' + code + email+ batch);
//   String down = '';
//   String downloadURL = await FirebaseStorage.instance.ref('imageResources/$email/$code-$batch/$imageName').getDownloadURL().then((value) {
//     setState(() {
//       imgRef.add(value);
//     });
//     return "";
//   }
//   );
//   return "";
// }
//
// Future<ListResult> listFiles()async{
//   String email = Provider.of<TaskData>(context, listen: false).userEmail;
//   String code = Provider.of<TaskData>(context, listen: false).courseCode;
//   String batch = Provider.of<TaskData>(context, listen: false).courseBatch;
//   ListResult results = await FirebaseStorage.instance.ref('imageResources/$email/$code-$batch').listAll();
//   return results;
// }
//
// Future selectFiles() async {
//   FilePickerResult? results = (await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.image));
//   if (results == null) return;
//   List<PlatformFile> files = results.files;
//   files.forEach((element) {
//     uploadFiles(File(element.path!));
//   });
//
// }

// Future uploadFiles(fileName) async{
//   String email = Provider.of<TaskData>(context, listen: false).userEmail;
//   String code = Provider.of<TaskData>(context, listen: false).courseCode;
//   String batch = Provider.of<TaskData>(context, listen: false).courseBatch;
//   String newFileName = fileName.toString().split('/').last;
//   final destination = 'imageResources/$email/$code-$batch/$newFileName';
//   try{
//     final ref = FirebaseStorage.instance.ref(destination);
//     ref.putFile(fileName!);
//   }
//   catch(e){
//     return null;
//   }
// }
}
