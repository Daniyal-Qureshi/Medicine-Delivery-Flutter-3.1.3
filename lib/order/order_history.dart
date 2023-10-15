import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:medicine_delivery/order/no_order.dart';
import 'package:medicine_delivery/shared/carousel.dart';
import 'package:medicine_delivery/shared/topbar.dart';
import 'package:medicine_delivery/user.dart' as app_user;
import 'dart:developer' as d;

class OrderHistory extends StatefulWidget {
  State<StatefulWidget> createState() => OrderHistoryState();
}

class OrderHistoryState extends State<OrderHistory> {
  late String email;
  @override
  Widget build(BuildContext context) {
    Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
        fetchData() async {
      email = app_user.User.getUserEmail();
      d.log(email);
      try {
        final querySnapshot = await FirebaseFirestore.instance
            .collection("purchase")
            .where('email', isEqualTo: email)
            .get();

        return querySnapshot.docs.isNotEmpty ? querySnapshot.docs : null;
      } catch (e) {
        d.log(e.toString());
        return null;
      }
    }

    return Scaffold(
      appBar: TopBar(title: "Orders"),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Carousel(),
          const SizedBox(
            height: 30,
          ),
          FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                // ignore: unnecessary_null_comparison

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Text("Problem in Firebase");
                } else if (snapshot.hasData) {
                  d.log("here");
                  // return Text(snapshot.data![0].data()['path'].toString());
                  // return Text(snapshot.data!.length.toString());
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final orderItem = snapshot.data![index].data();
                        return ListTile(
                          leading: Image(
                            image: AssetImage(orderItem['path']),
                          ),
                          title: Text(orderItem['name']),
                          subtitle: Text(orderItem['price']),
                          trailing: Icon(Icons.more_vert),
                        );
                      },
                    ),
                  );
                } else {
                  return const NoOrderFound();
                }
              }),
        ],
      ),
    );
  }
}
