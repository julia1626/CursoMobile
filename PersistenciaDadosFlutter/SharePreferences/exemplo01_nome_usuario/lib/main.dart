import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MaterialApp(
    home: UserNamePage(),
  ));
}

//classe da página

class UserNamePage extends StatefulWidget{
  const UserNamePage({super.key});

  @override
  _UserNamePageState createState() => _UserNamePageState();
}

class _UserNamePageState extends State<UserNamePage>{
  final TextEditingController _controller = TextEditingController();
  String _nomeSalvo = "";
  
  @override
  void initState() {
    super.initState();
    _carregarNomeSalvo();
  }

  void _carregarNomeSalvo() async {
    //usar o SharedPreferences para carregar as informações salvas
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomeSalvo = prefs.getString("nome")?? "";
    });
  }

  void _salvarNome() async {
    //usar o SharedPreferences para salvar as informações
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("nome", _controller.text);
    _carregarNomeSalvo();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Bem-Vindo ${_nomeSalvo==""?"Visitante": _nomeSalvo}"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField( 
              controller: _controller,
              decoration: InputDecoration(labelText: "Digite seu nome"),
            ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: _salvarNome,
                child: Text("Salvar"),
              )
            ],),
        ),
      );
  }
}