import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/database.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.
    final user = Provider.of<User>(context);
    final DatabaseService db = DatabaseService(uid: user.uid);
    return StreamBuilder<List<User>>(
      stream: db.users,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          List<User> users = snapshot.data;
          return StreamBuilder<QuerySnapshot>(
            stream: db.likes,
            builder: (context, snapshot) {
              if (snapshot.hasData){
                List<DocumentSnapshot> likes = snapshot.data.documents;
                for(var i = 0; i < users.length; i++){
                  for (var j = 0; j <likes.length; j++){
                    if(users[i].uid == likes[j]['to']){
                      users.removeAt(i);
                    }
                  }
                }
                return StreamBuilder<QuerySnapshot>(
                  stream: db.dislikes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData){
                      List<DocumentSnapshot> dislikes = snapshot.data.documents;
                      for(var i = 0; i < users.length; i++){
                        for (var j = 0; j <dislikes.length; j++){
                          if(users[i].uid == dislikes[j]['to']){
                            users.removeAt(i);
                          }
                        }
                      }
                      return Scaffold(
                        appBar: AppBar(
                          title: Text("CUagain"),
                          flexibleSpace: Container(
                            decoration: appBarDecoration,
                          ),
                        ),
                        body: Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    height: MediaQuery.of(context).size.height * 0.6,
                                    child: new TinderSwapCard(
                                        orientation: AmassOrientation.BOTTOM,
                                        totalNum: users.length,
                                        stackNum: 3,
                                        swipeEdge: 4.0,
                                        maxWidth: MediaQuery.of(context).size.width * 0.9,
                                        maxHeight: MediaQuery.of(context).size.width * 0.9,
                                        minWidth: MediaQuery.of(context).size.width * 0.8,
                                        minHeight: MediaQuery.of(context).size.width * 0.8,
                                        cardBuilder: (context, index) => Card(
                                          //child: Image.asset('${welcomeImages[index]}'),
                                          child: Text(users[index].name),
                                        ),
                                        cardController: controller = CardController(),
                                        swipeUpdateCallback:
                                            (DragUpdateDetails details, Alignment align) {
                                          /// Get swiping card's alignment
                                          if (align.x < 0) {
                                            //Card is LEFT swiping
                                          } else if (align.x > 0) {
                                            //Card is RIGHT swiping
                                          }
                                        },
                                        swipeCompleteCallback:
                                            (CardSwipeOrientation orientation, int index) {
                                          if (orientation == CardSwipeOrientation.RIGHT){
                                            db.sendLike(users[index].uid);
                                          }else if (orientation == CardSwipeOrientation.LEFT){
                                            db.sendDislike(users[index].uid);
                                          }
                                          /// Get orientation & index of swiped card!
                                        })),
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: null,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.info),
                                      onPressed: null,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.check),
                                      onPressed: null,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      );
                    }else{
                      return Container();
                    }
                  }
                );
              }
              else{
                return Container();
              }
            }
          );
        }else{
          return Container();
        }
      }
    );
  }


  /*List<Widget> cardList;
  void _removeCard(index){
    setState(() {
      cardList.removeAt(index);
    });
  }

  @override
  void initState(){
    super.initState();
    cardList = _getMatchCard();
  }
  /*void _showSettingsPanel() {
       showModalBottomSheet(context: context, builder: (context) {
         return Container(
           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
           child: SettingForm(),
         );
       });
     }*/
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<List<User>>(
      stream: DatabaseService().users,
      builder: (context, snapshot){
        return Scaffold(
          appBar: AppBar(
            title: Text('CUagain'),
            flexibleSpace: Container(
              decoration: appBarDecoration,
            ),
          ),
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: cardList,
            ),
          ),
        );
      },
    );
  }
  List<Widget> _getMatchCard(){
    List<MatchCard> cards = new List();
    cards.add(MatchCard(255, 0, 0, 10));
    cards.add(MatchCard(0, 255, 0, 20));
    cards.add(MatchCard(0, 0, 255, 30));

    List<Widget> cardList = new List();
    for (int i = 0; i < 3; i++){
      cardList.add(Positioned(
        top: cards[i].margin,
        child: Draggable(
          onDragEnd: (drag) => _removeCard(i),
          childWhenDragging: Container(),
          feedback: Card(
            elevation: 10,
            color: Color.fromARGB(255, cards[i].redColor, cards[i].greenColor, cards[i].blueColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular((10)),
            ),
            child: Container(
              child: Text("hi"),
              width: 240,
              height: 300,
            ),
          ),
          child: Card(
            elevation: 10,
            color: Color.fromARGB(255, cards[i].redColor, cards[i].greenColor, cards[i].blueColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular((10)),
            ),
            child: Container(
              child: Text("hi"),
              width: 240,
              height: 300,
            ),
          ),
        ),
      ));
    }
    return cardList;
  }*/
}



