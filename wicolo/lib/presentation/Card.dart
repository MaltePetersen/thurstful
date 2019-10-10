import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wicolo/state_management/Spieler.dart';

class Card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Spieler>(
        builder: (context, player, child) =>
            (player.generateRandomCardWidget()));
  }
}