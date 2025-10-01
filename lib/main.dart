import 'package:flutter/material.dart';
import 'package:graph_ql_demos/screens/country/country_screen.dart';
import 'package:graph_ql_demos/screens/rick_and_morty/rick_and_morty_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: ListView(
        children: [
          ListTile(
            title: Text("Rick And Morty"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RickAndMortyScreen()));
            },
          ),
          ListTile(
            title: Text("Country"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CountryScreen()));
            },
          ),
        ],
      ),
    );
  }
}
