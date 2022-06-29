import 'dart:convert';

import 'package:whowhats/models/team_model.dart';
import 'package:whowhats/utils/custom_textstyles.dart';
import 'package:whowhats/utils/tools_lib.dart';
import 'package:flutter/material.dart';
// import '../stars.dart';

class TeamCard extends StatefulWidget {
  final Team _team;
  final Function? updateTeamInTeamPage;
  const TeamCard(this._team, {this.updateTeamInTeamPage, Key? key})
      : super(key: key);

  @override
  State<TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key("article_btn_${widget._team.name}"),
      child: Card(
        color: LIGHT_GREY,
        child: Container(
          padding: const EdgeInsets.all(7),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Expanded(
                    //   child: Image.asset(
                    //     widget._team.imagesNames[0],
                    //     fit: BoxFit.fitWidth,
                    //     alignment: Alignment.topCenter,
                    //   ),
                    // )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _title(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        // if (widget.updateTeamInTeamPage == null) {
        //   Get.to(() => ArticlePage(widget._article));
        // } else {
        //   widget.updateArticleInArticlePage!(widget._article);
        // }
      },
    );
  }

  Widget _title() {
    return Text(
      widget._team.name,
      textAlign: TextAlign.left,
      style: CustomTextStyle.mediumBold(fontColor: COLOR_PRIMARY(context)),
    );
  }
}
