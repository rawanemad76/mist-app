import 'package:flutter/material.dart';
import 'package:mist_app/model/operations/data_models/road_header_data_model.dart';

class SelectRoadDropdownButton extends StatefulWidget {
  final List<RoadHeaderDataModel> itemsList;

  const SelectRoadDropdownButton({required this.itemsList, super.key});

  @override
  State<SelectRoadDropdownButton> createState() =>
      _SelectRoadDropdownButtonState();
}

class _SelectRoadDropdownButtonState extends State<SelectRoadDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButton(
        hint: const Text("Select Road"),
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),

        isExpanded: true,
        borderRadius: BorderRadius.circular(5),
        underline: const SizedBox(),
        //padding: const EdgeInsets.symmetric(horizontal: 5),
        value: selectedRoadIndex,

        onChanged: (newIndex) {
          setState(() {
            selectedRoadIndex = newIndex;
            selectedRoad = widget.itemsList[newIndex!].name;
            selectedRoadId = widget.itemsList[newIndex].id;
          });
        },
        items: _getItems(),
      ),
    );
  }

  _getItems() {
    List items = <DropdownMenuItem<int>>[];
    for (int i = 0; i < widget.itemsList.length; i++) {
      final item = DropdownMenuItem(
        value: i,
        child: Text(widget.itemsList[i].name),
      );
      items.add(item);
    }
    return items;
  }
}

int? selectedRoadIndex;
String? selectedRoad;
String? selectedRoadId;
