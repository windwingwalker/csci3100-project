import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ImageCapture extends StatefulWidget {
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
        // ratioX: 1.0,
        // ratioY: 1.0,
         // maxWidth: 512,
         // maxHeight: 512,
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<User>(
      stream: DatabaseService(uid: user.uid).user,
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
                  IconButton(
                    icon: Icon(Icons.last_page),
                    onPressed: () => Navigator.of(context).pushReplacementNamed('/profile'),
                  )
                ],
              ),
            ),
            body: ListView(
              children: <Widget>[
                if (_imageFile != null) ...[
                  Container(
                    height: 480,
                    child: Image.file(_imageFile),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        child: Icon(Icons.crop),
                        onPressed: _cropImage,
                      ),
                      FlatButton(
                        child: Icon(Icons.refresh),
                        onPressed: _clear,
                      ),
                    ],
                  ),
                  Uploader(file: _imageFile, user: user,),
                ]
              ],
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
  Uploader({Key key, this.file, this.user}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: "gs://csci3100-group4.appspot.com/");

  StorageUploadTask _uploadTask;

  void _startUpload(){
    int num = widget.user.imageNum + 1;
    String filePath = 'images/${widget.user.uid}/$num.png';
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
                    DatabaseService(uid: widget.user.uid).updateOneData('imageNum', FieldValue.increment(1));
                    Navigator.of(context).pushReplacementNamed('/profile');
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
          label: Text("Upload to Firebase"),
      );

    }

  }
}


