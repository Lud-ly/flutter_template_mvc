import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whowhats/models/scorer_model.dart';
import 'package:whowhats/models/team_model.dart';
import 'package:whowhats/utils/constant.dart';
import 'package:whowhats/utils/custom_textstyles.dart';
import 'package:whowhats/utils/tools_lib.dart';
import 'package:http/http.dart' as http;

class SerieAscorers extends StatefulWidget {
  @override
  _SerieAscorersState createState() => _SerieAscorersState();
}

class _SerieAscorersState extends State<SerieAscorers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _Header(),
          Expanded(child: ScorerTable()),
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
          "Classement Buteurs",
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

class ScorerTable extends StatelessWidget {
  const ScorerTable({Key? key}) : super(key: key);

  // Base API request to get response
  Future<List<Scorer>> getScorersByLeague() async {
    String base_url =
        "https://api.football-data.org/v2/competitions/SA/scorers";
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                    bottom: Radius.circular(10.0), top: Radius.circular(2.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [Text(snapshot.data[index].id.toString())],
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
          );
        }
      },
    );
  }
}
