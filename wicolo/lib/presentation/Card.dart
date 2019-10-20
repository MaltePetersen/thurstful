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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[                          Padding(padding: EdgeInsets.all(12.0),
                        child:

                          Text(
                            '${cardModel.getType()}',
                            style: Theme.of(context).textTheme.title.apply(fontSizeFactor: 1.5, color: Colors.white),
                            textDirection: TextDirection.ltr,
                          
                          ),
                        ),
                          Text(
                            '${cardModel.getSentence()}',
                      style: Theme.of(context).textTheme.body1.apply(  fontSizeFactor: 1.5, color: Colors.white),
                            textDirection: TextDirection.ltr,
                          ),
                        ]))))));
  }
}
