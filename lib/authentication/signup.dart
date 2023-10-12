import 'package:medicine_delivery/authentication/auth.dart';
import 'package:medicine_delivery/authentication/field.dart';
import 'package:medicine_delivery/authentication/footer.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:developer' as logger;

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignupState();
}

class SignupState extends State<Signup> {
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController createPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String errorMessage = "";
  bool isVisible = false;

  registerUser() async {
    if (confirmPasswordController.text != createPasswordController.text) {
      errorMessage = "Enter Password Correctly";
      isVisible = true;
    } else if (!EmailValidator.validate(emailController.text)) {
      errorMessage = "Type Correct Email address";
      isVisible = true;
    } else if (createPasswordController.text.length < 6) {
      errorMessage = "Password must be 6 characters long";
      isVisible = true;
    } else {
      final res = await Authentication.registerUser(
          emailController.text, createPasswordController.text);
      if (res == "ok") {
        confirmPasswordController.clear();
        createPasswordController.clear();
        emailController.clear();
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

  void setIsVisible(String _) {
    setState(() {
      isVisible = false;
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

              Field(
                setIsVisible: setIsVisible,
                labelText: "Email Address",
                icon: Icons.email,
                controller: emailController,
                type: TextInputType.emailAddress,
              ),
              Field(
                setIsVisible: setIsVisible,
                labelText: "Create Password",
                icon: Icons.lock,
                controller: createPasswordController,
                obscureText: true,
              ),
              Field(
                setIsVisible: setIsVisible,
                labelText: "Confirm Password",
                icon: Icons.lock,
                controller: confirmPasswordController,
                obscureText: true,
              ),

              Footer(
                  buttonLabelText: "Sign up",
                  descriptionText: "Already have an account ?",
                  buttonCallBack: registerUser,
                  toWidgetText: "Sign in",
                  toWidget: Login()),
            ],
          ),
        ),
      ]),
    );
  }
}
