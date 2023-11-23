import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:whowhats/screens/home.dart';
import 'package:whowhats/screens/welcome.dart';
import 'package:whowhats/reusable/miscellaneous/custom_textstyles.dart';
import 'package:whowhats/reusable/libs/tools_lib.dart';

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
    final double _footerHeight = kIsWeb ? 80 : SCREEN_HEIGHT(context) * 0.076;

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
                  key: const Key("goToAlarmeBtn"),
                ),
                _BubbleButton(
                  _PageType.account,
                  Icon(Icons.account_box),
                  "Account",
                  key: const Key("goToAccountBtn"),
                ),
                _BubbleButton(
                  _PageType.logout,
                  Icon(Icons.logout),
                  "Deconnexion",
                  key: const Key("goToDeconnexionBtn"),
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

class _BubbleButton extends StatefulWidget {
  final _PageType _page;
  final String _text;
  final Icon _icon;

  _BubbleButton(this._page, this._icon, this._text, {Key? key})
      : super(key: key);

  @override
  _BubbleButtonState createState() => _BubbleButtonState();
}

class _BubbleButtonState extends State<_BubbleButton> {
  bool _isTextVisible = false;

  void _toggleTextVisibility() {
    setState(() {
      _isTextVisible = !_isTextVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        children: [
          Flexible(
            child: IconButton(
              onPressed: () {
                _goTo(widget._page);
                _toggleTextVisibility();
              },
              color: Colors.black,
              icon: widget._icon,
              iconSize: kIsWeb ? 35 : MediaQuery.of(context).size.height * 0.04,
            ),
          ),
          if (_isTextVisible)
            Text(
              widget._text,
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
        Get.to(() => AccountPage());
        break;
      case _PageType.logout:
        FirebaseServices.disconnect();
        Get.to(() => Welcome());
        break;
    }
  }
}

enum _PageType { home, alarm, account, logout }
