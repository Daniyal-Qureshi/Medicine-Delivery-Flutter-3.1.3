import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  String buttonLabelText;
  String descriptionText;
  final VoidCallback buttonCallBack;
  String toWidgetText;
  Widget toWidget;
  Footer(
      {required this.buttonLabelText,
      required this.descriptionText,
      required this.buttonCallBack,
      required this.toWidgetText,
      required this.toWidget});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            width: 200,
            margin: const EdgeInsets.only(top: 5),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
              // ignore: sort_child_properties_last
              child: Text(buttonLabelText),
              onPressed: buttonCallBack,
            ))
      ]),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            descriptionText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => toWidget));
            },
            child: Text(
              toWidgetText,
              style: TextStyle(color: Colors.green),
            ),
          )
        ],
      )
    ]);
  }
}
