import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whowhats/screen/leagues/serieA/SerieAscorers.dart';
import 'package:whowhats/screen/leagues/serieA/SerieAteams.dart';
import 'package:whowhats/utils/custom_textstyles.dart';
import 'package:whowhats/utils/tools_lib.dart';
import 'package:get/get.dart';
import 'package:whowhats/widgets/custom_scaffold.dart';

class SerieA extends StatefulWidget {
  @override
  _SerieAState createState() => _SerieAState();
}

class _SerieAState extends State<SerieA> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          _Header(),
          Expanded(
              child: Row(
            children: [
              _BubbleButton(
                _PageType.scorers,
                "assets/images/SerieALogo.png",
                "scorers",
                key: const Key("goTomeBtn"),
              ),
              _BubbleButton(
                _PageType.teams,
                "assets/images/SerieALogo.png",
                "teams",
                key: const Key("goToBrowseBtn"),
              ),
              _BubbleButton(
                _PageType.scorers,
                "assets/images/SerieALogo.png",
                "scorers",
                key: const Key("goToHomBtn"),
              ),
              _BubbleButton(
                _PageType.teams,
                "assets/images/SerieALogo.png",
                "teams",
                key: const Key("goToBwseBtn"),
              ),
            ],
          )),
        ],
      ),
      scrollController: null,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Menu",
          style: CustomTextStyle.giant(),
        ),
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 2,
          child: Image(
            image: const AssetImage("assets/images/SerieALogo.png"),
            height: SCREEN_HEIGHT(context) * 0.15,
          ),
        ),
      ],
    );
  }
}

class _BubbleButton extends StatelessWidget {
  final _PageType _page;
  final String _imagePath;
  final String _text;
  const _BubbleButton(this._page, this._imagePath, this._text, {Key? key})
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
              icon: Image.asset(_imagePath),
              iconSize: kIsWeb ? 35 : SCREEN_HEIGHT(context) * 0.1425,
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
      case _PageType.scorers:
        Get.to(() => SerieAscorers());
        break;
      case _PageType.teams:
        Get.to(() => SerieAteams());
        break;
    }
  }
}

enum _PageType { scorers, teams }
