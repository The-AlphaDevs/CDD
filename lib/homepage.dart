import 'package:flutter/material.dart';
import 'home.dart';
import 'profile_main.dart';
import 'history_main.dart';
// import 'package:flutter_fire_auth/services/authentication.dart';

 class HomePage extends StatefulWidget {
    final VoidCallback logoutCallback;
    final VoidCallback loginCallbackRegister;
    final VoidCallback loginCallback;  
  //  final BaseAuth auth;
   HomePage({this.logoutCallback,this.loginCallback, this.loginCallbackRegister});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab=0;
  //  List<Widget> screens = [
  //   Home(),
  //   HistoryMain(loginCallback: widget.loginCallback, logoutCallback: widget.logoutCallback, loginCallbackRegister: widget.loginCallbackRegister),
  //   ProfileMain(),
  // ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();
  @override
  Widget build(BuildContext context) { 
      return Scaffold(
        
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 120,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Home(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                        color: currentTab == 0 ? Colors.amber : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.amber : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 120,
                    onPressed: () {
                        setState(() {
                        currentScreen =
                            HistoryMain(loginCallback: widget.loginCallback, logoutCallback: widget.logoutCallback, loginCallbackRegister: widget.loginCallbackRegister); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.history,
                          color: currentTab == 1 ? Colors.amber : Colors.grey,
                        ),
                        Text(
                          'History',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.amber : Colors.grey,
                          ),
                          ),
                      ],
                      
                    ),
                  ),
                  MaterialButton(
                    minWidth: 120,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            ProfileMain(loginCallback: widget.loginCallback, logoutCallback: widget.logoutCallback, loginCallbackRegister: widget.loginCallbackRegister); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: currentTab == 2 ? Colors.amber : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.amber : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}