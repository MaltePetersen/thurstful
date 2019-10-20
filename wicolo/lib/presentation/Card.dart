import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wicolo/state_management/CardModel.dart';

class Card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
            onTap: () => Provider.of<CardModel>(context).updateCard(),
            child: Consumer<CardModel>(
                builder: (context, cardModel, child) => (Container(
                    decoration: BoxDecoration(color: cardModel.getColor()),
                    child: Center(
                        child: RotatedBox(
                            quarterTurns: 1,
                            child: Column(children: <Widget>[
                              Text(
                                '${cardModel.getType()}',
                                style: Theme.of(context).textTheme.display1,
                              ),
                              Text(
                                '${cardModel.getSentence()}',
                                style: Theme.of(context).textTheme.display1,
                              ),
                            ]))))))));
  }
}
