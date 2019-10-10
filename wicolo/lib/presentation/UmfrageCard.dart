import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wicolo/presentation/Card.dart' as wicoloCard;
import 'package:wicolo/state_management/Spieler.dart';

class UmfrageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple,
        body: GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => wicoloCard.Card())),
            child: Center(
              child: RotatedBox(
                quarterTurns: 1,    child: Column(children: <Widget>[
              Text('Umfrage'),
            
                 Consumer<Spieler>(
                    builder: (context, player, child) => (Text(
                          '${player.players.isEmpty == false ? player.randomPlayer() : ""}',
                          style: Theme.of(context).textTheme.display1,
                        ))),
                ])
            ))));
  }
}