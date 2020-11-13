import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class Dropdown extends StatefulWidget {
  final String title;
  final List<dynamic> items;
  List<dynamic> _itemsChosen = [];

  List<dynamic> get itemsChosen => _itemsChosen;

  Dropdown({this.title, this.items, Key key}) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

/// This is the private State class that goes with Dropdown.
class _DropdownState extends State<Dropdown> {
  String dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiSelectFormField(
        chipBackGroundColor: Colors.grey,
        checkBoxActiveColor: Colors.grey[50],
        checkBoxCheckColor: Colors.lightBlue,
        dialogShapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        title: Text(
          widget.title,
        ),
        dataSource: widget.items
            .map((item) => {'display': item.name, 'value': item.name})
            .toList(),
        textField: 'display',
        valueField: 'value',
        okButtonLabel: 'OK',
        cancelButtonLabel: 'CANCEL',
        onSaved: (value) {
          if (value == null) return;
          setState(() {
            widget._itemsChosen = value;
          });
        },
      ),
    );
  }
}
