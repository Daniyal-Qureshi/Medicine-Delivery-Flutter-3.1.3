import 'package:flutter/material.dart';
import 'package:medicine_delivery/homepage/drawer.dart';
import 'package:medicine_delivery/shared/topbar.dart';
import '../authentication/login.dart';
import '../order/order_history.dart';
import '../order/show_medicine.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(title: "Home"),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: Card(
                  child: Image.asset("assets/home.png", fit: BoxFit.cover),
                ),
              ),
            ),
            ShowMedicine(),
          ],
        ),
        drawer: SideDrawer());
  }
}
