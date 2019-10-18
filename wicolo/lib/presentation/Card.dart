import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wicolo/state_management/CardModel.dart';

class Card extends StatelessWidget {
  var fido = Sentence(
    id: 0,
    name: 'Fido',
  );
  @override
  Widget build(BuildContext context) {
    return Consumer<CardModel>(
        builder: (context, cardModel, child) => (Scaffold(
            backgroundColor: cardModel.getColor(),
            body: GestureDetector(
                onTap: () => Provider.of<CardModel>(context).insertDog(fido),
                child: Center(
                    child: RotatedBox(
                        quarterTurns: 1,
                        child: Column(children: <Widget>[
                          Text(
                            '${cardModel.getType()}',
                            style: Theme.of(context).textTheme.display1,
                          ),      Text(
                            '${cardModel.getSentence()}',
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ])))))));
  }
}
