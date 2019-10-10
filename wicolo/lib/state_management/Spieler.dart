import 'package:flutter/material.dart';
import 'package:wicolo/presentation/NochNieCard.dart';
import 'package:wicolo/presentation/PflichtCard.dart';
import 'package:wicolo/presentation/SpielCard.dart';
import 'package:wicolo/presentation/UmfrageCard.dart';
import 'package:wicolo/presentation/VirusCard.dart';
import 'dart:math';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Spieler] does
/// _not_ depend on Provider.
class Spieler with ChangeNotifier {
  Spieler() {
    cards.add(UmfrageCard());
    cards.add(SpielCard());
    cards.add(VirusCard());
    cards.add(PflichtCard());
    cards.add(NochNieCard());
  }
  List<String> players = List();
  List<Widget> cards = List();
  Random rng = Random();
  String randomPlayer() {
    rng.nextInt(players.length);
    return players.elementAt(rng.nextInt((players.length)));
  }

  Widget generateRandomCardWidget() {
    int randomNumber = rng.nextInt(5);
    switch (randomNumber) {
      case 1:
        {
          return UmfrageCard();
        }
        break;

      case 2:
        {
          return SpielCard();
        }
        break;

      case 3:
        {
          return VirusCard();
        }
        break;
      case 4:
        {
          return PflichtCard();
        }
        break;
        
        default:
        {
          return NochNieCard();
        }
        break;
    }
  }

  void addAllPlayers(String playerOne, String playerTwo, String playerThree) {
    players.clear();
    players.add(playerOne);
    players.add(playerTwo);
    players.add(playerThree);
  }
}

