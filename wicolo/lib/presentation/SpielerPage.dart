import 'package:flutter/material.dart';
class SpielerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: const Text('Go to First'),
            // Pops Second Screen off the navigation stack
            onPressed: () => Navigator.of(context).pop(),
          ),
          Text('You have pushed the button this many times:'),
          // Consumer looks for an ancestor Provider widget
          // and retrieves its model (Spieler, in this case).
          // Then it uses that model to build widgets, and will trigger
          // rebuilds if the model is updated.
        ],
      ),
    );
  }
}