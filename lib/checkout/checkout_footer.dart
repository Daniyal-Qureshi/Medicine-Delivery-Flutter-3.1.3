import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_delivery/shared/show_dialog.dart';
import 'package:medicine_delivery/user.dart' as app_user;

// ignore: must_be_immutable
class CheckoutFooter extends StatefulWidget {
  String name, path, price, comments, location;
  CheckoutFooter(
      {super.key,
      required this.name,
      required this.path,
      required this.price,
      required this.comments,
      required this.location});

  @override
  State<CheckoutFooter> createState() => _CheckoutFooterState();
}

class _CheckoutFooterState extends State<CheckoutFooter> {
  bool isLoading = false;

  void purchaseProduct(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    CollectionReference reference =
        FirebaseFirestore.instance.collection('purchase');
    final email = app_user.User.getUserEmail();
    // Data to add to Firestore
    Map<String, dynamic> cartItem = {
      'email': email,
      'name': widget.name,
      'price': widget.price,
      'path': widget.path,
      'location': widget.location
    };

    try {
      await reference.add(cartItem);
      setState(() {
        isLoading = false;
      });
      // ignore: deprecated_member_use, use_build_context_synchronously
      ShowDialog.show(
          context, "Your order has been received", DialogType.success);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ShowDialog.show(context, e.toString(), DialogType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.shopping_bag, color: Colors.white),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        ),
        onPressed: () {
          purchaseProduct(context);
        },
        label: const Text("PROCEED TO CONFIRM"),
      ),
    );
  }
}
