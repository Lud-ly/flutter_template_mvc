import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:whowhats/models/team_model.dart';
import 'package:whowhats/utils/tools_lib.dart';

import 'teams_card.dart';

class TeamsList extends StatefulWidget {
  final List<Team> _teams;
  final Function? function;
  const TeamsList(this._teams, {this.function, Key? key}) : super(key: key);

  @override
  State<TeamsList> createState() => _TeamsListState();
}

class _TeamsListState extends State<TeamsList> {
  final ScrollController _controller = ScrollController();
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 4500), (timer) {
      _automaticScroll(timer);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SCREEN_HEIGHT(context) * 0.3,
      width: SCREEN_WIDTH(context),
      padding: kIsWeb
          ? const EdgeInsets.symmetric(horizontal: 50, vertical: 10)
          : const EdgeInsets.all(0),
      constraints: const BoxConstraints(maxHeight: 250),
      child: ListView.builder(
        shrinkWrap: true,
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: widget._teams.length,
        itemBuilder: (BuildContext context, int index) => SizedBox(
            width: 230,
            child: TeamCard(
              widget._teams[index],
              updateTeamInTeamPage: widget.function,
            )),
      ),
    );
  }

  _automaticScroll(Timer timer) {
    if (_controller.offset == _controller.position.maxScrollExtent) {
      timer.cancel();
    } else {
      _controller.animateTo(_controller.offset + 280,
          duration: const Duration(milliseconds: 1200), curve: Curves.linear);
    }
  }
}
