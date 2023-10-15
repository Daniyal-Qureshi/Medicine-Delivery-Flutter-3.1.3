import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:medicine_delivery/authentication/Signup.dart';
import 'package:medicine_delivery/authentication/auth.dart';
import 'package:medicine_delivery/authentication/footer.dart';
import 'package:medicine_delivery/shared/field.dart';
import 'package:medicine_delivery/shared/topbar.dart';
import '../homepage/homepage.dart';
import 'package:medicine_delivery/user.dart' as AppUser;

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Loginstate();
}

class Loginstate extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisible = false;
  String errorMessage = "";

  login() async {
    final res = await Authentication.loginUser(
        emailController.text, passwordController.text);
    if (res == "ok") {
      AppUser.User.setUserEmail(emailController.text);
      emailController.clear();
      passwordController.clear();

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

  void setIsVisible(String _) {
    setState(() {
      isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: ""),
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Field(
                setIsVisible: setIsVisible,
                labelText: "Email",
                icon: Icons.email,
                controller: emailController,
                type: TextInputType.emailAddress,
              ),
              Field(
                  setIsVisible: setIsVisible,
                  labelText: "Password",
                  icon: Icons.lock,
                  controller: passwordController,
                  obscureText: true),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
              Footer(
                  buttonLabelText: "Login",
                  descriptionText: "Don't have account ? create one",
                  buttonCallBack: login,
                  toWidgetText: "Sign up",
                  toWidget: Signup()),
            ],
          ),
        ),
      ]),
    );
  }
}
