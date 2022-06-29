import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whowhats/models/scorer_model.dart';
import 'package:whowhats/models/team_model.dart';
import 'package:whowhats/utils/constant.dart';
import 'package:whowhats/utils/custom_textstyles.dart';
import 'package:whowhats/utils/tools_lib.dart';
import 'package:http/http.dart' as http;

class SerieAteams extends StatefulWidget {
  @override
  _SerieAteamsState createState() => _SerieAteamsState();
}

class _SerieAteamsState extends State<SerieAteams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _Header(),
          Expanded(child: TeamsCard()),
        ],
      ),
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
          "Equipes",
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
        Text(
          "hello",
          style: CustomTextStyle.medium(fontColor: Colors.black),
        ),
      ],
    );
  }
}

class TeamsCard extends StatelessWidget {
  TeamsCard({Key? key}) : super(key: key);

  Future<List<Team>> getTeamInfos() async {
    String base_url = "https://api.football-data.org/v2/teams";
    final response =
        await http.get(Uri.parse(base_url), headers: Constant.getTokenAuth());
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      print("success");
      var result = json.decode(response.body);
      print(result['teams'][0]['crestUrl']);
      List<Team> teams = [];
      for (var i = 0; i < result['teams'].length; i++) {
        Team team = Team(
          id: result['teams'][i]['id'],
          name: result['teams'][i]['name'],
          shortName: result['teams'][i]['shortName'],
          phone: result['teams'][i]['phone'],
          crestUrl: result['teams'][i]['crestUrl'],
          address: result['teams'][i]['address'],
          website: result['teams'][i]['website'],
          email: result['teams'][i]['email'],
          clubColors: result['teams'][i]['clubColors'],
          founded: result['teams'][i]['founded'],
          venue: result['teams'][i]['venue'],
        );

        //Adding user to the list.
        teams.add(team);
      }
      print(teams);
      return teams;
    } else {
      print("not success");
      // If that response was not OK, throw an error.
      throw Exception('Failed to load json data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTeamInfos(),
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (ctx, index) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Expanded(
                        child: Image.network(snapshot.data[index].crestUrl))

                    // Text(snapshot.data[index].firstName),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
