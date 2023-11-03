import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:login/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String token="";
  String userName="";
  Future<void> data() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token=prefs.getString('access_token')! ;
      userName=prefs.getString('username')! ;
    });
  }
  @override
  void initState() {
    super.initState();
    data();
  }
  var result;
  Future<void> userDetail() async {
    data();
    print("Call Test");
    var headers = {
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET', Uri.parse('http://192.168.1.13:8080/api/$userName'));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseString = await response.stream.bytesToString();
        result = jsonDecode(responseString);
        print("hashtag: $result");
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error: $e");
    }

    print("Call End");
  }


  @override
  Widget build(BuildContext context) {
    userDetail();

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
              "Welcome\nBack\n $result['username']\n$result['phone']\n$result['email']",
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
