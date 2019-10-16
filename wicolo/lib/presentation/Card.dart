import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wicolo/state_management/CardModel.dart';

class Card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CardModel>(
        builder: (context, cardModel, child) => (Scaffold(
            backgroundColor: cardModel.getColor(),
            body: GestureDetector(
                onTap: () => Provider.of<CardModel>(context).updateCard(),
                child: Center(
                    child: RotatedBox(
                        quarterTurns: 1,
                        child: Column(children: <Widget>[
                          Text(
                            '${cardModel.getType()}',
                            style: Theme.of(context).textTheme.display1,
                          ),      Text(
                            '${cardModel.getPlayer()}',
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ])))))));
  }
}
