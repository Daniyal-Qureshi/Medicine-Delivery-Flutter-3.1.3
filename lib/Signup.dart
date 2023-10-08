import 'package:medicine_delivery/auth.dart';

import 'Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:developer' as logger;

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignupState();
}

class SignupState extends State<Signup> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _createPassword = TextEditingController();
  final TextEditingController _email = TextEditingController();
  String errorMessage = "";
  bool isVisible = false;
  registerUser() async {
    if (_confirmPassword.text != _createPassword.text) {
      errorMessage = "Enter Password Correctly";
      isVisible = true;
    } else if (!EmailValidator.validate(_email.text)) {
      errorMessage = "Type Correct Email address";
      isVisible = true;
    } else if (_createPassword.text.length < 6) {
      errorMessage = "Password must be 6 characters long";
      isVisible = true;
    } else {
      final res =
          await Authentication.registerUser(_email.text, _createPassword.text);
      if (res == "ok") {
        _name.clear();
        _confirmPassword.clear();
        _createPassword.clear();
        _email.clear();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Login()));
      } else {
        errorMessage = res;
        isVisible = true;
      }
    }

    setState(() {
      isVisible = isVisible;
      errorMessage = errorMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
        backgroundColor: Colors.green,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 200,
                    child: Image.asset("assets/logo.png"),
                  )),
              //error log
              Visibility(
                  visible: isVisible,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Color(int.parse("0xff${"f4c2c2"}")),
                        child: Align(
                          child: Text(errorMessage,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.red)),
                        )),
                  )),

              Padding(
                padding: const EdgeInsets.only(top: 20, left: 6, right: 6),
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      isVisible = false;
                    });
                  },
                  controller: _name,
                  maxLines: null,
                  textCapitalization: TextCapitalization.none,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.green,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      labelText: "First Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 10, right: 6),
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      isVisible = false;
                    });
                  },
                  controller: _email,
                  maxLines: null,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      labelText: "Email Address"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 10, right: 6),
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      isVisible = false;
                    });
                  },
                  controller: _createPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.green,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      labelText: "Create Password"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 10, right: 6),
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      isVisible = false;
                    });
                  },
                  controller: _confirmPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.green,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      labelText: "Confirm Password"),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    width: 200,
                    margin: const EdgeInsets.only(top: 5),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        child: const Text("Sign up"),
                        onPressed: registerUser))
              ]),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account ?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
