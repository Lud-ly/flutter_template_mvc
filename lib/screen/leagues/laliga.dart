import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whowhats/models/scorer_model.dart';
import 'package:whowhats/models/team_model.dart';
import 'package:whowhats/utils/constant.dart';
import 'package:http/http.dart' as http;

class Laliga extends StatefulWidget {
  @override
  _LaligaState createState() => _LaligaState();
}

class _LaligaState extends State<Laliga> {
  // Base API request to get response
  Future<List<Scorer>> getScorersByLeague() async {
    String base_url =
        "https://api.football-data.org/v2/competitions/PD/scorers";
    final response =
        await http.get(Uri.parse(base_url), headers: Constant.getTokenAuth());

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      print("success");
      var result = json.decode(response.body);
      print(result['scorers'][0]['team']);
      List<Scorer> players = [];
      for (var i = 0; i < result['scorers'].length; i++) {
        Scorer player = Scorer(
          id: result['scorers'][i]['player']['id'],
          name: result['scorers'][i]['player']['name'],
          firstName: result['scorers'][i]['player']['firstName'],
          dateOfBirth: result['scorers'][i]['player']['dateOfBirth'],
          position: result['scorers'][i]['player']['position'],
          countryOfBirth: result['scorers'][i]['player']['countryOfBirth'],
          nationality: result['scorers'][i]['player']['nationality'],
          numberOfGoals: result['scorers'][i]['numberOfGoals'],
          teamName: result['scorers'][i]['team']['name'],
        );

        //Adding user to the list.
        players.add(player);
      }

      return players;
    } else {
      print("not success");
      // If that response was not OK, throw an error.
      throw Exception('Failed to load json data');
    }
  }

  late Future<List<Team>> teams;

  // Base API request to get response
  Future<List<Team>> getAllTeams() async {
    String base_url = "https://api.football-data.org/v2/teams/PD";
    final response =
        await http.get(Uri.parse(base_url), headers: Constant.getTokenAuth());
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      print("success");
      var result = json.decode(response.body);

      print(result['teams'][0]['name']);
    }
    return teams;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Meilleurs Buteurs"),
          leading: Icon(
            Icons.sports_soccer,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: getScorersByLeague(),
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
                  itemBuilder: (ctx, index) => Card(
                    color: Theme.of(context).cardColor,
                    //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(10.0),
                          top: Radius.circular(2.0)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all((50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text(snapshot.data[index].id.toString())
                            ],
                          ),
                          Row(
                            children: [
                              Text(snapshot.data[index].name),
                              // Text(snapshot.data[index].firstName),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("née le "),
                              Text(snapshot.data[index].dateOfBirth),
                              Text(" en "),
                              Text(snapshot.data[index].nationality),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Joueur de"),
                              Text(snapshot.data[index].teamName),
                              // Text(snapshot.data[index].position),
                            ],
                          ),
                          Text(snapshot.data[index].countryOfBirth),
                          Text(snapshot.data[index].numberOfGoals.toString()),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
