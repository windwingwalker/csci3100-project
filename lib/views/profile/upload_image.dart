import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/database.dart';
import 'package:csci3100/services/imagedb.dart';
import 'package:csci3100/services/userdb.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ImageCapture extends StatefulWidget {
  final bool isFirst;

  const ImageCapture({this.isFirst});
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.amber,
          toolbarWidgetColor: Colors.indigo,
          toolbarTitle: 'Crop It',
        ),
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  Widget _title(){
    if (widget.isFirst){
      return MyFirstLoginTitle(text: "Upload your first photo", size: 30,);
    }else{
      return Text("Upload You photo", style: TextStyle(color: Colors.orange, fontSize: 20),);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserId>(context);
    return StreamBuilder<User>(
      stream: UserDB(uid: userId.uid).user,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          User user = snapshot.data;
          return Scaffold(
            bottomNavigationBar: BottomAppBar(
              color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                  IconButton(
                    icon: Icon(Icons.photo_library),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                  if (!widget.isFirst)...[
                    IconButton(
                      icon: Icon(Icons.last_page),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ]

                ],
              ),
            ),
            body: SafeArea(
              child: Container(
                decoration: bodyDecoration,
                child: ListView(
                  children: <Widget>[
                    _title(),
                    if (_imageFile != null) ...[
                      Container(
                        height: 450,
                        child: Image.file(_imageFile),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FlatButton.icon(
                            icon: Icon(Icons.crop),
                            onPressed: _cropImage,
                            label: Text("Crop"),
                          ),
                          FlatButton.icon(
                            icon: Icon(Icons.refresh),
                            onPressed: _clear,
                            label: Text("Refresh"),
                          ),
                        ],
                      ),
                      Uploader(file: _imageFile, user: user,isFirst: widget.isFirst,),

                    ]
                  ],
                ),
              ),
            ),
          );
        }else{
          return Container();
        }
      }
    );
  }
}

class Uploader extends StatefulWidget {
  final File file;
  final User user;
  final bool isFirst;
  Uploader({Key key, this.file, this.user, this.isFirst}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: "gs://csci3100-group4.appspot.com/");

  StorageUploadTask _uploadTask;
  String now = DateTime.now().toIso8601String().toString();

  void _startUpload(){
    String filePath = 'images/${widget.user.uid}/$now.png';
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }
  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null){
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot){
          var event = snapshot?.data?.snapshot;
          double progressPercent = event != null ? event.bytesTransferred / event.totalByteCount : 0;
          return Column(
            children: <Widget>[
              if (_uploadTask.isComplete)
                FlatButton.icon(
                  onPressed: () {
                    UserDB(uid: widget.user.uid).updateOneData('imageNum', FieldValue.increment(1));
                    ImageDB(uid: widget.user.uid).saveImageUrl(now, widget.isFirst);
                    if (widget.isFirst){
                      Navigator.of(context).pushReplacementNamed('/bottombar');
                    }else{
                      Navigator.of(context).pop();
                    }
                  },
                  icon: Icon(Icons.done),
                  label: Text("Finish")
                ),
              if (_uploadTask.isPaused)
                FlatButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: _uploadTask.resume,
                ),
              if (_uploadTask.isInProgress)
                FlatButton(
                  child: Icon(Icons.pause),
                  onPressed: _uploadTask.pause,
                ),
              LinearProgressIndicator(value: progressPercent,),
              Text('${(progressPercent * 100).toStringAsFixed(2)} %'),
            ],
          );
        }
      );
    }else{
      return FlatButton.icon(
          onPressed: _startUpload,
          icon: Icon(Icons.cloud_upload),
          label: Text("Upload"),
      );
    }
  }
}


