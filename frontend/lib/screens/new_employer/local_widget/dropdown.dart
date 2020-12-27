import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class Dropdown extends StatefulWidget {
  final String title;
  List<dynamic> _items = [];
  // List<dynamic> _itemsChosen = [];
  String _itemsChosen =""; 
  _DropdownState state = _DropdownState();

  String get itemsChosen => _itemsChosen;
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
      child: DropDownFormField(
        titleText: widget.title,
        value: widget._itemsChosen,
        dataSource: widget._items
            .map((item) => {'display': item.name, 'value': item.id.toString()})
            .toList(),
        textField: 'display',
        valueField: 'value',
        onChanged: (value) {
          if (value == null) return;
          setState(() {
        
            /*widget._itemsChosen = widget._items
                .where((element) => value.contains(element.name))
                .toString();*/
                widget._itemsChosen=value;
            
          });
        },
        
      ),
    );
  }
}
