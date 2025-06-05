import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaTarefas extends StatefulWidget{
  const TelaTarefas({super.key});

  @override
  State<TelaTarefas> createState() => _TelaTarefasState();
  //_TelaTarefasState createState() => _TelaTarefasState();
}

class _TelaTarefasState extends State<TelaTarefas>{
  //atributos
  String _nome = "";
  bool _darkMode = false;
  bool _logado = false;
  List<String> _tarefas = [];
  final TextEditingController _tarefaController = TextEditingController();


  //métodos
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carregarPreferencias();
  }

  _carregarPreferencias() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = prefs.getString("nome") ?? "";
      _darkMode = prefs.getBool("darkMode") ?? false;
      _logado = prefs.getBool("logado") ?? false;
      _tarefas = prefs.getStringList(_nome) ?? [];
    });
  if(_logado){
    Navigator.pushNamed(context, "/");
  }
  }

  //build
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedTheme(
      data: _darkMode ? ThemeData.dark() : ThemeData.light(), 
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tarefas de $_nome"),
          actions: [
            IconButton(
              onPressed: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                _logado = false;
                prefs.setBool("logado", _logado);
                prefs.setString("nome", "");
                Navigator.pushNamed(context, "/");
              }, 
              icon: Icon(Icons.logout))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _tarefaController,
                decoration: InputDecoration(labelText: "Insira Nova Tarefa"),
              ),
              ElevatedButton(
                onPressed: _adicionarTarefa, 
                child: Text("Adicionar Tarefa")
              ),
              //listar as Tarefas
              Expanded(
                child: ListView.builder(
                  itemCount: _tarefas.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      title: Text(_tarefas[index]),
                    );
                  })
                )
            ],
          ),
          ),
      )
    );
  }

  _adicionarTarefa() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(_tarefaController.text.trim().isNotEmpty){
      _tarefas.add(_tarefaController.text.trim());
      prefs.setStringList(_nome, _tarefas);
      setState(() {
        _tarefaController.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tarefa adicionada com sucesso!")));
      });
    }else{
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Preeencha o campo da tarefa")));
    }
  }
}