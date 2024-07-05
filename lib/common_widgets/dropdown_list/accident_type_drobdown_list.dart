import 'package:flutter/material.dart';

class AccidentTypeDropdownButton extends StatefulWidget {
  final void Function(String value) onChange;

  const AccidentTypeDropdownButton({required this.onChange, super.key});

  @override
  State<AccidentTypeDropdownButton> createState() =>
      _AccidentTypeDropdownButtonState();
}

class _AccidentTypeDropdownButtonState
    extends State<AccidentTypeDropdownButton> {
  String? accidentType;

  List itemsList = [
    "Crash accident",
    "Heavy transport accident",
    "Fire accident",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButton(
        hint: const Text("Type"),
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
        isExpanded: true,
        borderRadius: BorderRadius.circular(5),
        underline: const SizedBox(),
        value: accidentType,
        onChanged: (newValue) {
          setState(() {
            accidentType = newValue.toString();
            widget.onChange(accidentType!);
          });
        },
        items: itemsList.map((valueItem) {
          return DropdownMenuItem(
            value: valueItem,
            child: Text(valueItem),
          );
        }).toList(),
      ),
    );
  }
}
