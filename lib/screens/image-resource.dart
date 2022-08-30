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

class ImageResources extends StatefulWidget {
  static String id = 'image-resources';

  @override
  _ImageResourcesState createState() => _ImageResourcesState();
}

class _ImageResourcesState extends State<ImageResources> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  List<String> imgRef = [];

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
            Navigator.pushNamed(context, AddImage.id);
          },
          child: Icon(Icons.upload_rounded),
        ),
        body: ColorfulSafeArea(
            color: Color(0xFF13192F),
            child: Column(
              children: [
                CustomNavigation("Images",(value) {
                  _globalKey.currentState?.openDrawer();
                }),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('imageURLs').where('courseCode', isEqualTo:code).where('courseBatch', isEqualTo: batch)
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
                                  return Container(
                                    margin: EdgeInsets.all(3.0),
                                    child: FadeInImage.assetNetwork(
                                      fadeInDuration: Duration(seconds: 1),
                                      fadeInCurve: Curves.bounceIn,
                                      fit: BoxFit.cover,
                                      image: data['url'],
                                      placeholder: 'images/loading.gif'),
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
