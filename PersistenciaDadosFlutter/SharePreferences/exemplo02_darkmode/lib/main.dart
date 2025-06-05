import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void mian(){
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark
    ),
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _carregarPreferencias();
  }

  void _carregarPreferencias() async {
    //carregar as preferencias pelo SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool("darkMode") ?? false;
    });
  }

  void mudarDarkMode() async{
    setState(() {
      _darkMode = !_darkMode;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("darkMode", _darkMode);
    _carregarPreferencias();
  }

  //build
  @override
  Widget build(BuildContext context){
    return AnimatedTheme(
      data: _darkMode ? ThemeData.dark(): ThemeData.light(),
      duration: Duration(microseconds: 500),
      child: Scaffold(
        appBar: AppBar(title: Text("Teste DarkMode"),),
        body: Center(
          child: Switch(
            value: _darkMode, 
            onChanged: (value) => mudarDarkMode()),
            ),
      ));
  }
}