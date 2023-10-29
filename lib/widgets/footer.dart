import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:whowhats/screens/home.dart';
import 'package:whowhats/screens/welcome.dart';
import 'package:whowhats/utils/custom_textstyles.dart';
import 'package:whowhats/utils/tools_lib.dart';

import '../api/firebase_services.dart';
import '../screens/account.dart';
import '../screens/alarm.dart';

class Footer extends StatefulWidget {
  final ScrollController? _scrollControlleur;
  const Footer([this._scrollControlleur, Key? key]) : super(key: key);

  @override
  State<Footer> createState() => FooterState();
}

class FooterState extends State<Footer> {
  bool _isHidden = false;

  @override
  void initState() {
    super.initState();

    widget._scrollControlleur?.addListener(_listen);
  }

  @override
  dispose() {
    widget._scrollControlleur?.removeListener(_listen);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _footerHeight = kIsWeb ? 80 : SCREEN_HEIGHT(context) * 0.086;

    Widget footer = SizedBox(
      height: _footerHeight,
      width: SCREEN_WIDTH(context),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _BubbleButton(
                  _PageType.home,
                  Icon(Icons.home),
                  "Home",
                  key: const Key("goToHomeBtn"),
                ),
                _BubbleButton(
                  _PageType.alarm,
                  Icon(Icons.alarm),
                  "Alarme",
                  key: const Key("goToBrowseBtn"),
                ),
                _BubbleButton(
                  _PageType.account,
                  Icon(Icons.account_box),
                  "Account",
                  key: const Key("goToCommunityBtn"),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (widget._scrollControlleur != null) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        child: Wrap(
          children: [footer],
        ),
        height: _isHidden ? 0 : _footerHeight,
      );
    }
    return footer;
  }

  _listen() {
    final direction = widget._scrollControlleur?.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      if (_isHidden) {
        _isHidden = false;
      }
      setState(() {});
    } else if (direction == ScrollDirection.reverse) {
      if (!_isHidden) {
        _isHidden = true;
      }
      setState(() {});
    }
  }
}

class _BubbleButton extends StatelessWidget {
  final _PageType _page;
  final String _text;
  final Icon _icon;

  _BubbleButton(this._page, this._icon, this._text, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SCREEN_WIDTH(context) * 0.2,
      child: Column(
        children: [
          Flexible(
            child: IconButton(
              onPressed: () => _goTo(_page),
              color: Color.fromARGB(255, 6, 20, 131),
              icon: _icon,
              iconSize: kIsWeb ? 35 : SCREEN_HEIGHT(context) * 0.06,
            ),
          ),
          Text(
            _text,
            style: CustomTextStyle.small(fontColor: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _goTo(_PageType page) {
    switch (page) {
      case _PageType.home:
        Get.to(() => HomePage());
        break;
      case _PageType.alarm:
        Get.to(() => AlarmPage());
        break;
      case _PageType.account:
        FirebaseServices.disconnect();
        Get.to(() => Welcome());

        break;
    }
  }
}

enum _PageType { home, alarm, account }
