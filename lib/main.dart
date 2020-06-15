import 'package:flutter/material.dart';
import 'package:flutter_fire_auth/introslides.dart';
// import 'package:introduction_screen/introduction_screen.dart';
import 'ui_access.dart';
import 'welcome.dart';
import 'Login-Register/login.dart';
import 'profile.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aatmanirbhar Farmer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WelcomePage2(),
      routes: {
              "/login": (_) => new LoginPage(),
              "/ui_access": (_) => new UiAccess(),
              "/intro": (_) => new IntroSlides(),
              },
    );
  }
}

// class IntroSlides extends StatefulWidget {
//   @override
//   _IntroSlidesState createState() => _IntroSlidesState();
// }

// class _IntroSlidesState extends State<IntroSlides> {
//   final introKey = GlobalKey<IntroductionScreenState>();

//   void _onIntroEnd(context) {
//     Navigator.pushReplacementNamed(context, "/ui_access");
//   }

//   @override
//   Widget build(BuildContext context) { 
//     const bodyStyle = TextStyle(fontSize: 19.0);
//     const pageDecoration = const PageDecoration(
//       titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
//       titlePadding: EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 10.0),
//       bodyTextStyle: bodyStyle,
//       descriptionPadding: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 25.0),
//       pageColor: Colors.white,
//       imagePadding: EdgeInsets.all(15.0),
//     );
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text("Aatmanirbhar Farmer"),
//           backgroundColor: Colors.amber,
//         ),
//       body: IntroductionScreen(
//             pages: [
//               PageViewModel(
//                   title: "Crop Disease Detector",
//                   body: "Take a picture of your crop to detect diseases.",
//                   decoration: pageDecoration,
//                   image: Image.asset('images/image1.jpg')
//               ),
//               PageViewModel(
//                 title: "Crop History",
//                 body:
//                     "Retrieve past photographs and history of diseases that affected your crop",
//                 decoration: pageDecoration,
//                 image: Image.asset('images/image1.jpg'),
//               ),
//               PageViewModel(
//                 title: "Crop Advisory",
//                 body:
//                     "Recieve Treatment advice and Remedies for diseases detected",
//                 decoration: pageDecoration,
//                 image: Image.asset('images/image1.jpg'),
//               ),
//             ],
//             onDone: () => _onIntroEnd(context),
//             onSkip: () => _onIntroEnd(context),
//             showSkipButton: true,
//             skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.amber, fontSize: 17)),
//             done: const Text('Get Started', style: TextStyle(fontWeight: FontWeight.w900,color: Colors.amber,fontSize: 17 )),
//             next: const Text('Next', style: TextStyle(fontWeight: FontWeight.w900,color: Colors.amber,fontSize: 17)),
//             dotsDecorator: DotsDecorator(
//               size: const Size.square(10.0),
//               activeSize: const Size(20.0, 10.0),
//               activeColor: Colors.amber,
//               // Theme.accentColor,
//               color: Colors.black26,
//               spacing: const EdgeInsets.symmetric(horizontal: 5.0),
//               activeShape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0)),
//             ),
//           )
//     );
//   }
// }



  
