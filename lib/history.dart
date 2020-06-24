
import 'package:flutter/material.dart';
import 'history_detail.dart';
import 'Login-Register/utils/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// final _auth = FirebaseAuth.instance;
//     final user1 = await _auth.currentUser();
//     emailID = user1.email;
//     displayName =  user1.displayName;
//     // await _auth.currentUser().then((value) => emailID = value.email);
//     print(emailID);
//     // await _auth.currentUser().then((value) => displayName = value.displayName);
//     print(displayName);

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<HistoryPage> {
  
  @override
  void initState(){
    super.initState();
    //inputData();
    getData();
  }
  List items = getDummyList();

  List urls = new List();
  List diseases = new List();
  List remedies = new List();
  List timestamps = new List();

  void getData() async {
    final _auth = FirebaseAuth.instance;
    final user1 = await _auth.currentUser();
    print(user1);
    String emailID = user1.email;

    var userQuery =  Firestore.instance.collection('users').document(emailID).collection('History').orderBy('Time');
    userQuery.getDocuments().then((data){ 
          if (data.documents.length > 0){
              setState(() {
                for( var i = 0; i < data.documents.length; i++)
                {
                    urls.add(data.documents[i].data['Image URL']);
                    diseases.add(data.documents[i].data['Predicted Disease']);
                    remedies.add(data.documents[i].data['Remedies']);
                    timestamps.add(data.documents[i].data['Time']);
                }
                }
              );
          }
      });
      
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Aatmarnirbhar Farmer'),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        child: ListView.builder(
        
      itemCount: urls.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(urls[index]),
          background: Container(
            alignment: AlignmentDirectional.centerEnd,
            color: Colors.red,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) {
            setState(() {
              urls.removeAt(index);
            });
          },
          direction: DismissDirection.endToStart,
          child: Card(
              color: Colors.white,
              elevation: 5,
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
              child: Container(
              //height: 150.0,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topLeft: Radius.circular(5)
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(urls[index])
                      )
                    ),
                  ),
                  Container(
                    height: 200,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            diseases[index],style: TextStyle(color: Colors.black,
                            ),
                          ),
                          Flexible(
                            child:Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 5),
                              child: Container(
                              // width: 260,
                              child: Text("Disease: "+diseases[index],style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),),
                              
                            ),
                          ),),
                          
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                              child: Container(
                              width: 105,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.teal),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: FlatButton(
                                child: Text("View More",textAlign: TextAlign.justify,style: TextStyle(color: Colors.teal,)),
                                onPressed: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => HistDetail()));
                                
                                },
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    )),
    );
  }

  static List getDummyList() {
    List list = List.generate(10, (i) {
      return "Crop ${i + 1}";
    });
    return list;
  }

  // static List getImageUrls()
  // {

  // }
   // static List getDiseases()
  // {

  // } 
  // static List getRemedies()
  // {

  // } 
  // static List getTimestamps()
  // {

  // }
}


class MyListView extends StatefulWidget {
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  int _upCounter = 0;
  int _downCounter = 0;
  var _newdata;
  var myDatabase = Firestore.instance;

  void _putdata() {
    var myDatabase = Firestore.instance;
    myDatabase.collection('newDoc1').document("outsideData$_upCounter").setData(
      {
        "data": "Uploaded outsider data $_upCounter",
      },
    );
    _upCounter++;
  }

  @override
  Widget build(BuildContext context) {
    _putdata();
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebse Listview'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyList()),
              );
            },
            icon: Icon(Icons.multiline_chart),
          )
        ],
      ),
      // body: Center(
      //   child: Text(
      //       "Cloud Firestore contains this sentence:\nFetch Attemp: $_downCounter\nData: $_datafromfirestore"),
      // ),
      body: StreamBuilder(
        stream: myDatabase.collection('newDoc1').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Center(
              child: Text("\nCaught an error in the firebase thingie... :| "),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text("\nHang On, We are building your app !"),
            );
          } else {
            var mydata = snapshot.data;
            print(mydata);
            _newdata = mydata.documents[_downCounter]["data"];
            return Center(
              child: Text(
                  "Cloud Firestore contains this sentence:\nFetch Attempt: $_downCounter\nData: $_newdata"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _downCounter++;
          });
        },
        child: Icon(Icons.cloud_download),
        tooltip: 'Download Data',
      ),
    );
  }
}

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {

  String email;
  
  Future emailgetter() async{
    final _auth = FirebaseAuth.instance;
    final user = await _auth.currentUser();
    email = user.email;
  }
  
  @override
  Widget build(BuildContext context) {
    
    //final _auth = FirebaseAuth.instance;
    emailgetter();

    return Scaffold(
      appBar: AppBar(
        title: Text("ListView Firestore"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("users").document(email).collection('History').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              if (!snapshot.hasData) return Text('No data finded!');
              return Card(
              elevation: 5,
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
              child: Container(
              //height: 150.0,
              child: Row(
                children: <Widget>[
                  
                  Container(
                    height: 200.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topLeft: Radius.circular(5)
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("https://crop-protection-network.s3.amazonaws.com/articles/Downy-Mildew-D.-Mueller-15.jpg")
                      )
                    ),
                  ),
                  Container(
                    height: 200,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Text(
                          //   items[index],
                            
                          // ),
                          Flexible(
                            child:Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 5),
                              child: Container(
                              // width: 260,
                              child: Text("Disease: Tomato_Early_Blight",style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),),
                              
                            ),
                          ),),
                          
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                              child: Container(
                              width: 105,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.teal),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: FlatButton(
                                child: Text("View More",textAlign: TextAlign.justify,style: TextStyle(color: Colors.teal,)),
                                onPressed: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => HistDetail()));
                                
                                },
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
          }
        },
      ),
    );
  }
}