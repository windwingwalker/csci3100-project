import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/imagedb.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  PageController ctrl = PageController(viewportFraction: 0.8);
  int currentPage = 0;
  @override
  void initState(){
    super.initState();
    ctrl.addListener((){
      int next = ctrl.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  _buildStoryPage(String url, bool active){
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(url),
        ),
        boxShadow: [BoxShadow(color: Colors.black87, blurRadius: blur, offset: Offset(offset, offset))]
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserId>(context);
    return StreamBuilder<List<MyUrl>>(
      stream: ImageDB(uid: userId.uid).images,
      initialData: [],
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<MyUrl> images = snapshot.data;
          List<String> urls = [];
          for (var image in images) {
            urls.add(image.url);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Gallery"),
              flexibleSpace: Container(
                decoration: appBarDecoration,
              ),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("Add new image"),
                  onPressed: ()=> Navigator.of(context).pushNamed('/image_upload'),
                ),
              ],
            ),
            body: Container(
              decoration: bodyDecoration,
              child: PageView.builder(
                controller: ctrl,
                itemCount: urls.length,
                itemBuilder: (context, int currentIndex) {
                  if (urls.length >= currentIndex) {
                    bool active = currentIndex == currentPage;
                    return _buildStoryPage(urls[currentIndex], active);
                  }
                  return Loading();
                },
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}