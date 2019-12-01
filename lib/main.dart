import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wicolo/presentation/MyApp.dart';
import 'package:wicolo/state_management/CardModel.dart';


Future main() async {
  runApp(
    // Provide the model to all widgets within the app. We're using
    // ChangeNotifierProvider because that's a simple way to rebuild
    // widgets when a model changes. We could also just use
    // Provider, but then we would have to listen to Spieler ourselves.
    //
    // Read Provider's docs to learn about all the available providers.
    ChangeNotifierProvider(
      // Initialize the model in the builder. That way, Provider
      // can own Spieler's lifecycle, making sure to call `dispose`
      // when not needed anymore.
      builder: (context) => CardModel(),
      child: MyApp(),
    ),
  );
}
