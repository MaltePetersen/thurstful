import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wicolo/presentation/Card.dart' as wicoloCard;
import 'package:wicolo/state_management/Spieler.dart';


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
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Spieler 1',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextFormField(
                      controller: secondController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Spieler 2',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextFormField(
                      controller: thirdController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'Spieler 3',
                          labelStyle: TextStyle(color: Colors.white)),
                    )
                  ],
                )),
            const SizedBox(height: 30),
            RaisedButton(
              color: Color.fromRGBO(201, 57, 57, 1.0),
              child: const Text(
                'Modus auswählen',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                Provider.of<Spieler>(context, listen: false).addAllPlayers(
                    myController.text,
                    secondController.text,
                    thirdController.text);
                // Pushs the SecondScreen widget onto the navigation stack
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => wicoloCard.Card()));
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
