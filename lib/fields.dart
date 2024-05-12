// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String operation;

  void Function(double) updateSMV;
  void Function(double) updateQTY;
  void Function(double) updateCOT;
  void Function(double) updateMIT;
  void Function(double) updateODT;
  void Function()? calculate;

  CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      required this.operation,
      required this.updateSMV,
      required this.updateQTY,
      required this.updateCOT,
      required this.updateMIT,
      required this.updateODT,
      this.calculate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: SizedBox(
          height: 45.0,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: label,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            ),
            onChanged: (value) {
              double data;
              data = double.tryParse(value) ?? 0.0;
              if (operation == "SMV") {
                updateSMV(data);
              } else if (operation == "QTY") {
                updateQTY(data);
              } else if (operation == "ODT") {
                updateODT(data);
              } else if (operation == "COT") {
                updateCOT(data);
              } else if (operation == "MIT") {
                updateMIT(data);
              }
              calculate?.call();
            },
          )),
    );
  }
}
