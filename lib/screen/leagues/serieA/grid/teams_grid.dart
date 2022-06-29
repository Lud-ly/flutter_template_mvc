import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whowhats/models/team_model.dart';
import 'package:whowhats/utils/tools_lib.dart';

import 'teams_card.dart';

class TeamsGrid extends StatefulWidget {
  final List<Team> _teams;
  const TeamsGrid(this._teams, {Key? key}) : super(key: key);

  @override
  State<TeamsGrid> createState() => _TeamsGridState();
}

class _TeamsGridState extends State<TeamsGrid> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      controller: _controller,
      padding: kIsWeb ? const EdgeInsets.all(0) : const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: kIsWeb
          ? (SCREEN_WIDTH(context) / (SCREEN_HEIGHT(context)) * 2.5).round()
          : 2,
      childAspectRatio: kIsWeb ? 1.4 : 3 / 4,
      children: widget._teams.map((item) => TeamCard(item)).toList(),
    );
  }
}
