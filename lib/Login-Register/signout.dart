// //11 June 2020
// import 'package:flutter/material.dart';
// import 'utils/firebase_auth.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Out, Gadin Ha !'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text("Sign Out page"),
//             RaisedButton(
//               child: Text("Log out"),
//               onPressed: ()
//               {
//                 Navigator.pop(context);
//                 AuthProvider().logOut();
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }