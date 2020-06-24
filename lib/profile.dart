import 'package:flutter/material.dart';
import 'Login-Register/utils/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {  // 
  bool _authStatus = true;
  bool _status = true;
  String displayName = "Loading ...";
  String emailID = "Loading ...";
  String mobileNum;
  String state;
  bool res = false;
  

 // FirebaseAuth _auth = FirebaseAuth.instance;
  final FocusNode myFocusNode = FocusNode();
  void inputData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;
    print(uid);
  }

  void getData() async {
    final _auth = FirebaseAuth.instance;
    final user1 = await _auth.currentUser();
    print(user1);
    emailID = user1.email;

    var userQuery =  Firestore.instance.collection('users').where('email', isEqualTo: emailID).limit(1);
      userQuery.getDocuments().then((data){ 
          if (data.documents.length > 0){
              setState(() {
                    displayName = data.documents[0].data['displayName'];
                    emailID = data.documents[0].data['email'];
                    state = data.documents[0].data['state'];
                    mobileNum = data.documents[0].data['mobile_number'];
                  });
          }
      });
      
  }
  bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
  void saveData() async {
    if((mobileNum.length != 10) || ! isNumeric(mobileNum))
    {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid Input !"),
            backgroundColor: Colors.redAccent,
            content: Container(
            child: Text("Please enter again",style: TextStyle(color: Colors.black, fontWeight:FontWeight.bold),
            ),
          ),
          );
        });

    }
    else
    {
      await Firestore.instance.collection('users').document(emailID)
            .updateData({
              "mobile_number": mobileNum,
              "state": state
            }).then((result){
              print("Data updated");
              res = true;
            }).catchError((onError){
            print("onError");
            }); 
      
      if(res == true)
      {
        showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.greenAccent,
            title: Text("Success !"),
            content: Container(
            child: Text("Changes Saved !",style: TextStyle(color: Colors.black, fontWeight:FontWeight.bold),
                ),
              ),
            );
          }
        );
      }

      else
      {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
            return AlertDialog(
            backgroundColor: Colors.redAccent,
            title: Text("Error !"),
            content: Container(
            child: Text("Please Try Again", style: TextStyle(color: Colors.black, fontWeight:FontWeight.bold),
             ),
            ),
          );
        }
      ); 
      }
     
    }
   
  }

  final nameHolder = TextEditingController(); 
  final nameHolder1 = TextEditingController(); 
  clearTextInput(){
    nameHolder.clear();
    nameHolder1.clear();
  }

  @override
  void initState(){
    super.initState();
    inputData();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // getData();
    FirebaseAuth.instance.currentUser() != null ?_authStatus = true : print(FirebaseAuth.instance.currentUser());
 
    return new Scaffold(
        // backgroundColor: Color(0xFFF9AA33),
        appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Aatmanirbhar Farmer'),
        backgroundColor: Colors.amber,
      ),
      body: new Container(
      // color: Color(0xFFF9AA33),
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 50.0,
                // color:  Color(0xFFF9AA33),
                child: new Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // new Icon(
                            //   Icons.arrow_back_ios,
                            //   color: Colors.black,
                            //   size: 22.0,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(left: 0.0),
                              child: new Text('PROFILE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 23.0,
                                      fontFamily: 'sans-serif-light',
                                      color: Colors.black,
                                      ),
                                  textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        )),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 20.0),
                    //   child: new Stack(fit: StackFit.loose, children: <Widget>[
                    //     new Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: <Widget>[
                    //         new Container(
                    //             width: 140.0,
                    //             height: 140.0,
                    //             decoration: new BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               image: new DecorationImage(
                    //                 image: new ExactAssetImage(
                    //                     'images/image1.jpg'),
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             )),
                    //       ],
                    //     ),
                    //     Padding(
                    //         padding: EdgeInsets.only(top: 90.0, right: 100.0),
                    //         child: new Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: <Widget>[
                    //             new CircleAvatar(
                    //               backgroundColor: Colors.red,
                    //               radius: 25.0,
                    //               child: new Icon(
                    //                 Icons.camera_alt,
                    //                 color: Colors.white,
                    //               ),
                    //             )
                    //           ],
                    //         )),
                    //   ]),
                    // )
                  ],
                ),
              ),
              new Container(
                // color: Color(0xFFF9AA33),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Personal Information',
                                    style: TextStyle(
                                        fontSize: 21.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              // new Column(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   mainAxisSize: MainAxisSize.min,
                              //   children: <Widget>[
                              //     _status ? _getEditIcon() : new Container(),
                              //   ],
                              // )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    "Name",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                       ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 7.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: Text(
                                  "$displayName", style: TextStyle(
                                        fontSize: 16.0,color: Colors.black
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Divider(
                        color: Colors.black,
                        endIndent: 10.0,
                        indent: 10.0,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Email ID',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 7.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: 
                                Text(
                                   "$emailID",
                                    style: TextStyle(
                                        color:Colors.black,
                                        fontSize: 16.0,
                                       ),
                                 ),
                                // new TextField(
                                //   decoration: const InputDecoration(
                                //       hintText: ""),
                                  
                                //   enabled: !_status,
                                // ),
                              ),
                            ],
                          )),

                      Divider(
                        color: Colors.black,
                        endIndent: 10.0,
                        indent: 10.0,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Mobile Number:  $mobileNum',
                                    style: TextStyle(
                                        color:Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  controller: nameHolder1,
                                  enableInteractiveSelection: true,
                                  decoration: const InputDecoration(
                                  hintText: "Edit Mobile Number",labelStyle: TextStyle(color:Colors.black),),
                                  enabled: _status,
                                  onChanged: (value) {
                                  mobileNum = value;
                                },
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              // Expanded(
                              //   child: Container(
                              //     child: new Text(
                              //       'Pin Code',
                              //       style: TextStyle(
                              //           fontSize: 16.0, 
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //   ),
                              //   flex: 2,
                              // ),
                              Expanded(
                                child: Container(
                                  child: new Text(
                                    'City : $state',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                                flex: 2,
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              // Flexible(
                              //   child: Padding(
                              //     padding: EdgeInsets.only(right: 10.0),
                              //     child: new TextField(
                              //       enableInteractiveSelection: true,
                              //       decoration: const InputDecoration(
                              //           hintText: "Enter Pin Code"),
                              //       enabled: _status,
                              //     ),
                              //   ),
                              //   flex: 2,
                              // ),
                              Flexible(
                                child: new TextField(
                                  autocorrect: true,
                                  controller: nameHolder,
                                  enableInteractiveSelection: true,
                                  decoration: const InputDecoration(
                                  hintText: "Edit City", labelStyle: TextStyle(color:Colors.black),),
                                  enabled: _status,
                                  onChanged: (value) {
                                  state = value;
                                },

                                ),
                                flex: 2,
                              ),
                            ],
                          )),
                          
                      // !_status ? _getActionButtons() : new Container(),
                       _getActionButtons(),
                    ],
                  ),
                ),
              ),
              
                FlatButton(
                  
                  child: Text("Log out"),
                  textColor: Colors.white,
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17)),
                  onPressed: ()
                  { 
                    Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/'));
                    AuthProvider().logOut();

                  },
                )
              
              
            // :RaisedButton(
            //  child: Text("Please Log In First !!"),
            //  onPressed : (){},)
            ],
          ),
        ],
      ),
    ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new FlatButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  saveData();                
                  // setState(() {
                  //   _status = true;
                  //   FocusScope.of(context).requestFocus(new FocusNode());
                  // });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new FlatButton(
                  child: new Text("Cancel"),
                  textColor: Colors.white,
                  color: Colors.red,                
                  onPressed: () {
                  // setState(() {
                  //   // _status = true;
                  //   // FocusScope.of(context).requestFocus(new FocusNode());

                  // });
                  clearTextInput();
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  // Widget _getEditIcon() {
  //   return new GestureDetector(
  //     child: new CircleAvatar(
  //       backgroundColor: Colors.red,
  //       radius: 14.0,
  //       child: new Icon(
  //         Icons.edit,
  //         color: Colors.white,
  //         size: 16.0,
  //       ),
  //     ),
  //     onTap: () {
  //       setState(() {
  //         _status = false;
  //       });
  //     },
  //   );
  // }



}