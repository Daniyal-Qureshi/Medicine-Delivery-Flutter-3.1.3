import 'package:flutter/material.dart';
import 'package:medicine_delivery/purchase.dart';

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
                builder: (BuildContext context) => Purchase(
                      name: medicine["name"],
                      path: medicine["path"],
                      price: medicine["price"],
                    )));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                medicine["path"],
                height: 110,
              ),
              const SizedBox(height: 5),
              Text(
                medicine["name"],
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),
              Text(
                "Rs. ${medicine['price']}",
                style: const TextStyle(color: Colors.red, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
