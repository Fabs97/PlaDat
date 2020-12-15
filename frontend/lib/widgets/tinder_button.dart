import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:frontend/utils/custom_theme.dart';

class TinderButton extends StatelessWidget {
  String _label;
  CardController _cardController;
  bool _discardButton;

  TinderButton(
      {Key key,
      @required String label,
      @required CardController cardController,
      @required bool discardButton})
      : this._label = label,
        this._cardController = cardController,
        this._discardButton = discardButton,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: _discardButton
          ? CustomTheme().accentColor
          : CustomTheme().primaryColor,
      textColor: _discardButton ? CustomTheme().accentTextColor : Colors.white,
      elevation: 5.0,
      child: Text(_label),
      onPressed: () {
        _discardButton
            ? _cardController.triggerLeft()
            : _cardController.triggerRight();
      },
    );
  }
}
