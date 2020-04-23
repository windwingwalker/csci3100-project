import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/imagedb.dart';
import 'package:csci3100/services/userdb.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:csci3100/shared/loading.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  final String uid;
  const Intro({this.uid});
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
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
    final double top = active ? 50 : 100;

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
    return StreamBuilder<User>(
      stream: UserDB(uid: widget.uid).user,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          User user = snapshot.data;
          return StreamBuilder<List<MyUrl>>(
            stream: ImageDB(uid: user.uid).images,
            initialData: [],
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData){
                List<MyUrl> images = snapshot.data;
                List<String> urls = [];
                for (var image in images) {
                  urls.add(image.url);
                }
                return Scaffold(
                  appBar: AppBar(
                    title: Text(user.name),
                    flexibleSpace: Container(
                      decoration: appBarDecoration,
                    ),
                  ),
                  body: Container(
                    decoration: bodyDecoration,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          height: 500.0,
                          child: PageView.builder(
                            controller: ctrl,
                            itemCount: urls.length,
                            itemBuilder: (context, int currentIndex){
                              if (urls.length >= currentIndex) {
                                bool active = currentIndex == currentPage;
                                return _buildStoryPage(urls[currentIndex], active);
                              }
                              return Loading();
                            },
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            MyIntroText(user.name, "name"),
                            SizedBox(width: 20,),
                            MyIntroText(user.age.toString(), "age"),
                            SizedBox(width: 20,),
                            MyIntroText(user.college, "college"),
                          ],
                        ),
                        MyIntroText(user.desc, "desc")
                      ],
                    ),
                  ),
                );
              }else{
                return Loading();
              }
            }
          );
        }else{
          return Loading();
        }

      }
    );
  }
}
