import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class Dropdown extends StatefulWidget {
  final String title;
  List<dynamic> _items = [];
  List<dynamic> _itemsChosen = [];
  _DropdownState state = _DropdownState();

  List<dynamic> get itemsChosen => _itemsChosen;
  set items(List<dynamic> items) => state.setItems(items);
  
  Dropdown({this.title, Key key}) : super(key: key);

  @override
  _DropdownState createState() => state;
}

/// This is the private State class that goes with Dropdown.
class _DropdownState extends State<Dropdown> {
  String dropdownValue;

  void setItems(List<dynamic> items) {
    setState(() {
      widget._items = items;
    });
  }

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
        dataSource: widget._items
            .map((item) => {'display': item.name, 'value': item.name})
            .toList(),
        textField: 'display',
        valueField: 'value',
        okButtonLabel: 'OK',
        cancelButtonLabel: 'CANCEL',
        onSaved: (value) {
          if (value == null) return;
          setState(() {
            widget._itemsChosen = widget._items
                .where((element) => value.contains(element.name))
                .toList();
          });
        },
      ),
    );
  }
}
