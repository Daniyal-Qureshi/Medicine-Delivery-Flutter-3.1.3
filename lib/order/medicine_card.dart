import 'package:flutter/material.dart';
import 'package:medicine_delivery/checkout/checkout.dart';

// ignore: must_be_immutable
class MedicineCard extends StatelessWidget {
  late Map<String, dynamic> medicine;

  MedicineCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Checkout(
                        name: medicine["name"],
                        path: medicine["path"],
                        price: medicine["price"],
                      )));
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                medicine["path"],
                height: 100,
              ),
              const SizedBox(height: 5),
              Text(
                medicine["name"],
                style: const TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                "Rs. ${medicine['price']}",
                style: const TextStyle(color: Colors.red, fontSize: 15),
              ),
            ],
          ),
        ));
  }
}
