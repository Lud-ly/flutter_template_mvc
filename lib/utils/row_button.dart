import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whowhats/reusable/libs/tools_lib.dart';
import 'package:whowhats/reusable/theme/theme.dart';

class RowButton extends StatelessWidget {
  final Icon _icon;
  final String _msg;
  final Function _onPressed;
  final Color _rowColor;
  final TextStyle _textStyle;
  const RowButton(
      this._icon, this._msg, this._onPressed, this._rowColor, this._textStyle,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        splashColor: kBlackColor,
        child: Container(
          decoration: BoxDecoration(
            color: _rowColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: SCREEN_WIDTH(context) / 2.7,
              ),
              _icon,
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(
                        15), //apply padding to all four sides
                    child: Text(
                      _msg,
                      style: _textStyle,
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
            ],
          ),
        ),
        onTap: () {
          _onPressed();
        },
      ),
    );
  }
}
