import 'package:flutter/material.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

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
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: MultiSelectDialogField(
          items: widget._items
              .map((item) => MultiSelectItem<dynamic>(item.name, item.name))
              .toList(),
          title: Text(widget.title),
          selectedColor: CustomTheme().secondaryColor,
          buttonIcon: Icon(Icons.arrow_drop_down),
          buttonText: Text(widget.title),
          onConfirm: (value) {
            if (value == null) return;
            setState(() {
              widget._itemsChosen = widget._items
                  .where((element) => value.contains(element.name))
                  .toList();
            });
          },
          chipDisplay: MultiSelectChipDisplay(
            height: 33.0,
            scroll: true,
          ),
        ),
      ),
    );
  }
}
