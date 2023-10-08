import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medicine_delivery/auth.dart';
import 'homepage.dart';
import 'Signup.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Loginstate();
}

class Loginstate extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isVisible = false;
  String errorMessage = "";
  login() async {
    final res = await Authentication.loginUser(_email.text, _password.text);
    if (res == "ok") {
      var user = await Hive.openBox('User');
      await user.put("email", _email.text);
      _email.clear();
      _password.clear();


      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      errorMessage = res;
      isVisible = true;
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
        title: const Text("Login"),
        backgroundColor: Colors.green,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                      width: 200,
                      child: Image(
                        image: AssetImage("assets/logo.png"),
                      ))),
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
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                  controller: _email,
                  onChanged: (text) {
                    setState(() {
                      isVisible = false;
                    });
                  },
                  maxLines: null,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                      labelText: "Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                  controller: _password,
                  onChanged: (text) {
                    setState(() {
                      isVisible = false;
                    });
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.green,
                      ),
                      labelText: "Password"),
                ),
              ),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    width: 200,
                    margin: const EdgeInsets.only(top: 5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      child: const Text("Sign in"),
                      onPressed: login,
                    ))
              ]),
              const Padding(padding: EdgeInsets.only(top: 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have account ? create one",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Signup()));
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: Colors.green),
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
