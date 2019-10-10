import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

void main() {
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
      builder: (context) => Spieler(),
      child: MyApp(),
    ),
  );
}

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

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> players = List();
  final myController = TextEditingController();
  final secondController = TextEditingController();
  final thirdController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    secondController.dispose();
    thirdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementSpieler method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Wicolo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: myController,
                      decoration: InputDecoration(
                        labelText: 'Spieler 1',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextFormField(
                      controller: secondController,
                      decoration: InputDecoration(
                        labelText: 'Spieler 2',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextFormField(
                      controller: thirdController,
                      decoration: InputDecoration(
                          labelText: 'Spieler 3',
                          labelStyle: TextStyle(color: Colors.white)),
                    )
                  ],
                )),
            const SizedBox(height: 30),
            RaisedButton(
              child: const Text(
                'Modus auswählen',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                print("Container pressed");
                Provider.of<Spieler>(context, listen: false).addAllPlayers(
                    myController.text,
                    secondController.text,
                    thirdController.text);
                // Pushs the SecondScreen widget onto the navigation stack
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Card()));
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

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

class Card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Spieler>(
        builder: (context, player, child) =>
            (player.generateRandomCardWidget()));
  }
}

class UmfrageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple,
        body: GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Card())),
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

class PflichtCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Card())),
           child: Center(
              child: RotatedBox(
                quarterTurns: 1,    child: Column(children: <Widget>[
              Text('Pflicht'),
            
                 Consumer<Spieler>(
                    builder: (context, player, child) => (Text(
                          '${player.players.isEmpty == false ? player.randomPlayer() : ""}',
                          style: Theme.of(context).textTheme.display1,
                        ))),
                ])
            ))));
  }
}

class VirusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen,
        body: GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Card())),
       child: Center(
              child: RotatedBox(
                quarterTurns: 1,    child: Column(children: <Widget>[
              Text('Virus'),
            
                 Consumer<Spieler>(
                    builder: (context, player, child) => (Text(
                          '${player.players.isEmpty == false ? player.randomPlayer() : ""}',
                          style: Theme.of(context).textTheme.display1,
                        ))),
                ])
            ))));
  }
}

class NochNieCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Card())),
      child: Center(
              child: RotatedBox(
                quarterTurns: 1,    child: Column(children: <Widget>[
              Text('Ich hab noch nie...'),
            
                 Consumer<Spieler>(
                    builder: (context, player, child) => (Text(
                          '${player.players.isEmpty == false ? player.randomPlayer() : ""}',
                          style: Theme.of(context).textTheme.display1,
                        ))),
                ])
            ))));
  }
}
class SpielCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue,
        body: GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Card())),
         child: Center(
              child: RotatedBox(
                quarterTurns: 1,    child: Column(children: <Widget>[
              Text('Spiel'),
            
                 Consumer<Spieler>(
                    builder: (context, player, child) => (Text(
                          '${player.players.isEmpty == false ? player.randomPlayer() : ""}',
                          style: Theme.of(context).textTheme.display1,
                        ))),
                ])
            ))));
  }
}
