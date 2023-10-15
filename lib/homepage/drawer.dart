import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medicine_delivery/authentication/login.dart';
import 'package:medicine_delivery/order/order_history.dart';

class SideDrawer extends StatelessWidget {
  late String email;
  SideDrawer({Key? key}) : super(key: key) {
    var user = Hive.box('User');
    email = user.get("email") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            color: Colors.green,
            child: Column(children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 10),
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/man.png"),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Text(
                        "${email}",
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: Text("Profile"),
              ),
              ListTile(
                leading: const Icon(
                  Icons.shopping_cart_checkout,
                  color: Colors.white,
                ),
                title: const Text("Your Orders"),
                onTap: () async {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => OrderHistory()));
                },
              ),
              const ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: Text("Settings"),
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: const Text("Logout"),
                onTap: () async {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).popUntil((route) => route.isFirst);

                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()));
                },
              ),
            ])));
  }
}
