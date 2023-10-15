import 'package:flutter/material.dart';
import 'package:medicine_delivery/checkout/checkout_footer.dart';
import 'package:medicine_delivery/checkout/location_dropdown.dart';
import 'package:medicine_delivery/shared/topbar.dart';

// ignore: must_be_immutable
class Checkout extends StatefulWidget {
  String name, path, price;

  Checkout({required this.name, required this.path, required this.price});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late List<String> locations = [];

  TextEditingController commentsController = TextEditingController();

  String? selectedLocation;

  void setLocation(location) {
    setState(() {
      selectedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(title: "Check out"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Image.asset(widget.path),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Rs. ${widget.price}",
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontFamily: ''),
              ),
              Text(
                widget.name,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: double.infinity,
                  child: LocationDropDown(
                    selectedLocation: selectedLocation,
                    setLocation: setLocation,
                  )),
              const Divider(
                color: Colors.grey,
              ),
              const Text("7 days Returns policy",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: TextField(
                  maxLines: null,
                  expands: true,
                  controller: commentsController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.comment,
                        color: Colors.green,
                      ),
                      labelText: "Your Comments"),
                ),
              ),
            ]),
          ),
        ),
        bottomNavigationBar: CheckoutFooter(
            price: widget.price,
            name: widget.name,
            path: widget.path,
            location: selectedLocation ?? "",
            comments: commentsController.text));
  }
}
