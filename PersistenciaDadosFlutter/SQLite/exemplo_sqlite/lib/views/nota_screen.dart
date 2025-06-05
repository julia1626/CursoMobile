import 'package:exemplo_sqlite/controllers/notas_controller.dart';
import 'package:flutter/material.dart';

class NotaScreen extends StatefulWidget{
  @override
  State<_NotaScreenState> createState() => _NotaScreenState();
  }

  class _NotaScreenState extends State<NotaScreen>{
    final NotasController _notasController = NotasController();

    //lista para as notas
    List<Nota> _notes = [];
    bool _isLoading = true;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadNotas(); //carregar as Notas no Inicio
  }

  Future<void> _loadNotas() async{
    setState(() {
      _isLoading = true;
    });
    try {
      _notes = await _notasController.fetchNotas();
    } catch (e) {
      print("Erro ao Carregar : $e");
    }
  }
  }