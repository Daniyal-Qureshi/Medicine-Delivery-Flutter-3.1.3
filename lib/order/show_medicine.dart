import 'package:flutter/material.dart';
import 'package:medicine_delivery/order/medicine_card.dart';

// ignore: use_key_in_widget_constructors
class ShowMedicine extends StatefulWidget {
  @override
  ShowMedicineState createState() => ShowMedicineState();
}

class ShowMedicineState extends State<ShowMedicine> {
  List<Map<String, dynamic>> medicineData = [
    {
      "name": "Arinac 200 mg (Zafa)",
      "path": "assets/arinac.jpeg",
      "price": "300",
    },
    {
      "name": "Rigix 200 mg (Abbot)",
      "path": "assets/rigix.jpg",
      "price": "400",
    },
    {
      "name": "Augmentin 375 mg (gsk)",
      "path": "assets/augmentin.jpeg",
      "price": "600",
    },
    {
      "name": "Brufen 400 mg",
      "path": "assets/brufen.jpg",
      "price": "200",
    },
    {
      "name": "Disprin Original CCL Pharma",
      "path": "assets/disprin.jpg",
      "price": "300",
    },
    {
      "name": "Folic Acid",
      "path": "assets/folic.jpg",
      "price": "240",
    },
    {
      "name": "Voltral 50 mg",
      "path": "assets/voltral.jpg",
      "price": "200",
    },
    {
      "name": "motilium 300mg",
      "path": "assets/motilium.jpg",
      "price": "200",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.8,
      padding: EdgeInsets.all(20),
      child: GridView.builder(
        itemCount: medicineData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
        itemBuilder: (BuildContext context, int index) {
          return MedicineCard(medicine: medicineData[index]);
        },
      ),
    );
  }
}
