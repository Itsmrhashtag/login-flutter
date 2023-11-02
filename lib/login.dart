import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:login/classes/oauth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future<void> login() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    // final SharedPreferences prefs = await _prefs;
    try {
      // Prepare the HTTP request headers, including the Basic Authorization header.
      var headers = {
        'Authorization': 'Basic aGFzaHRhZzoxMjM0',
      };


      void showAlertDialog(String title, String message) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      }

      // Get the username and password entered by the user.
      var username = emailController.text;
      var password = passwordController.text;

      // Define the URL for the login request and include the username and password.
      var loginUrl =
          'http://192.168.1.13:8080/oauth/token?grant_type=password&username=$username&password=$password&scope=read';

      // Send the HTTP POST request with the headers.
      var request = http.Request('POST', Uri.parse(loginUrl));
      request.headers.addAll(headers);

      // Get the streamed response from the request.
      http.StreamedResponse response = await request.send();

      // Parse the response content as JSON.
      var result = jsonDecode(await response.stream.bytesToString());
      print(result['access_token']);
      await _prefs.setString('access_token',result['access_token'] );


      // Handle the result here (e.g., authentication success or failure).


      if (response.statusCode == 200) {
        // User registration successful, handle the response here
        print(result);
        // Map<String, dynamic> output= json.decode(response);
        Navigator.pushReplacementNamed(context, 'home');
        showAlertDialog("Success", "User Loging successful");

      }else if(response.statusCode == 400) {
        // User registration successful, handle the response here
        showAlertDialog("Failed", "User Not registered");
      }
      // If login is successful, navigate to the "home" screen.

    } catch (err) {
      // Handle any exceptions that might occur during the request.
      print(err);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assests/login.png"), // Correct the path to your image.
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: 130),
                child: Text(
                  "Welcome\nBack",
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    right: 35,
                    left: 35,
                  ),

                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Please enter Username'),
                          ]),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Please enter Password'),
                            MinLengthValidator(8,
                                errorText:
                                'Password must be atleast 8 digit'),
                            PatternValidator(r'(?=.*?[#!@$%^&*-])',
                                errorText:
                                'Password must be atlist one special character')
                          ]),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff4c505b),
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () async {
                                  print("pressed");
                                  if (_formkey.currentState!.validate()) {
                                    print('login form submiitted');
                                    await login();
                                  }
                                  // Call the login function to make the HTTP request.

                                },
                                icon: Icon(Icons.arrow_forward),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "register");
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  color: Color(0xff4c505b),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  color: Color(0xff4c505b),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}