import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  int value = 0;
  List<String> players = List();
  String player = "";

  void increment() {
    value += 1;
    notifyListeners();
  }

  void addPlayer(String player) {
    players.add(player);
  }

  void changePlayer(String player) {
    this.player = player;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the Spieler didn't reset back to zero; the application
        // is not restarted.
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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
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
            TextFormField(
              controller: myController,
              decoration: InputDecoration(
                labelText: 'Spieler 1',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            TextFormField(
              controller: myController,
              decoration: InputDecoration(
                labelText: 'Spieler 2',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            TextFormField(
              controller: myController,
              decoration: InputDecoration(
                  labelText: 'Spieler 3',
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 30),
            RaisedButton(
              child: const Text(
                'Go to Second',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                Provider.of<Spieler>(context, listen: false)
                    .changePlayer(myController.text);
                // Pushs the SecondScreen widget onto the navigation stack
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SpielerPage()));
              },
            ),
            Consumer<Spieler>(
                builder: (context, player, child) => Text(
                      '${player.player}',
                      style: Theme.of(context).textTheme.display1,
                    )),
            Consumer<Spieler>(
              builder: (context, Spieler, child) => Text(
                '${Spieler.value}',
                style: Theme.of(context).textTheme.display1,
              ),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Center(
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
            Consumer<Spieler>(
              builder: (context, Spieler, child) => Text(
                '${Spieler.value}',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Provider.of is another way to access the model object held
        // by an ancestor Provider. By default, even this listens to
        // changes in the model, and rebuilds the whole encompassing widget
        // when notified.
        //
        // By using `listen: false` below, we are disabling that
        // behavior. We are only calling a function here, and so we don't care
        // about the current value. Without `listen: false`, we'd be rebuilding
        // the whole MyHomePage whenever Spieler notifies listeners.
        onPressed: () =>
            Provider.of<Spieler>(context, listen: false).increment(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
