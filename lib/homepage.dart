import 'package:flutter/material.dart';
import 'package:medicine_delivery/drawer.dart';
import 'Login.dart';
import 'cart.dart';
import 'show_medicine.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Homepage"),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 50,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "Search for medicine",
                            fillColor: Colors.white70),
                      ))),
              SizedBox(
                width: double.infinity,
                child: Image.asset("assets/1.jpg"),
              ),
              Card(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                    Column(children: [
                      InkWell(
                        child: Image.asset(
                          "assets/medicine.png",
                          width: 100,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => ShowMedicine()));
                        },
                      ),
                      const Text("Order Medicines"),
                    ]),
                    Column(
                      children: [
                        InkWell(
                          child: Image.asset(
                            "assets/orders.png",
                            width: 100,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => cart()));
                          },
                        ),
                        const Text("My Orders")
                      ],
                    )
                  ])),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: Image.asset(
                      "assets/refer.jpg",
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ))
            ],
          ),
        ),
        drawer: SideDrawer()
        
        
        )

        
        
        ;
  }
}
