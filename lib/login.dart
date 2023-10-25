import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController= TextEditingController();

class _MyLoginState extends State<MyLogin> {


  login() async{

    try{

      // if (response.statusCode == 200) {
      //
      // }
      // else {
      //   print(response.reasonPhrase);
      // }
    }catch(err){
      print(err);
    }
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assests/login.png"),fit: BoxFit.cover)
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35,top: 130),
                child: Text("Welcome\nBack",style: TextStyle(color: Colors.white,fontSize: 33),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5,
                  right: 35,
                  left: 35),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(
                              color: Color(0xff4c505b),
                              fontSize: 27,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xff4c505b),
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () async{
                                  print("pressed");
                                  var headers = {
                                    'Authorization': 'Basic aGFzaHRhZzoxMjM0'
                                  };
                                  var request = http.Request('POST', Uri.parse('http://localhost:8080/oauth/token?grant_type=password&username=admin&password=1234&scope=read'));

                                  request.headers.addAll(headers);

                                  http.StreamedResponse response = await request.send();
                                  var result = jsonDecode(await response.stream.bytesToString());
                                  print(result);
                                  // login(emailController.text.toString(),passwordController.text.toString());
                                }
                                , icon: Icon(Icons.arrow_forward))
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: () {
                            Navigator.pushNamed(context, "register");
                          }, child: Text(
                              "Sign Up",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: Color(0xff4c505b)
                            ),
                          )),
                          TextButton(onPressed: () {}, child: Text(
                            "Forgot Password",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color(0xff4c505b)
                            ),
                          ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
