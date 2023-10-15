import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoOrderFound extends StatelessWidget {
  const NoOrderFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Lottie.asset('assets/animations/order_animation.json'),
        ),
        const Text(
          "No Order Found",
          style: TextStyle(color: Colors.red, fontSize: 20),
        )
      ],
    );
  }
}
