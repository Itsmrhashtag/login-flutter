import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String token="";
  Future<void> data() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token=prefs.getString('access_token')! ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      // decoration: BoxDecoration(
      // image: DecorationImage(image: AssetImage("assests/login.png"),fit: BoxFit.cover)
      // )
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: EdgeInsets.only(left: 35, top: 130),
            child: Text(

              "Welcome\nBack\n$token",
              style: TextStyle(color: Colors.black, fontSize: 33),
            ),
          ),
          SingleChildScrollView(

          )
        ]),
      ),
    );
  }
}
