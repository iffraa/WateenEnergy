import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/colour.dart';
import '../utils/strings.dart';

class VariablesChkBox extends StatefulWidget {
   List checkListItems = [];
   final Function(List) onClickAction;

  VariablesChkBox(this.checkListItems, this.onClickAction);

  @override
  State<VariablesChkBox> createState() => _VariablesChkBoxState();
}

class _VariablesChkBoxState extends State<VariablesChkBox> {
  List multipleSelected = [];

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              children: List.generate(
                widget.checkListItems.length,
                    (index) => CheckboxListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    widget.checkListItems[index]["title"],
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  value: widget.checkListItems[index]["value"],
                  onChanged: (value) {
                    setState(() {
                      widget.checkListItems[index]["value"] = value;
                      if (multipleSelected.contains(widget.checkListItems[index])) {
                        multipleSelected.remove(widget.checkListItems[index]);
                      } else {
                        multipleSelected.add(widget.checkListItems[index]);
                      }
                      widget.onClickAction(multipleSelected.toSet().toList());

                    });
                  },
                ),
              ),

            ),
          );
        });
  }
}
