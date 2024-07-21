import 'dart:developer';

import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'addincidentpage.dart';
import '../widgets/incidentlistpage.dart';

class Homepage extends StatefulWidget{

  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final GlobalKey<IncidentListPageState> _incidentListKey = GlobalKey<IncidentListPageState>();

  Future<void> _navigateToAddIncidentPage() async{
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddIncidentPage()
      )
    );

    if(result != null){
      result ? log('Se ha agregado un incidente') : log('no se ha agregado incidente');
    }

    _incidentListKey.currentState?.refreshData();
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aviso'),
          content: const Text(
            'Esta seguro que quieres eliminar todos la informacion de la App?', 
            style: TextStyle(
              color: Colors.black
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                _deleteAllIncidents(); // Ejecuta la acción
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Si'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAllIncidents() async {
    await DatabaseHelper().deleteAllIncidents();
    _incidentListKey.currentState?.refreshData();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('VigilApp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () { },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 225,
                child: Image.asset('assets/images/applogo.png')
                ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showWarningDialog(context),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Reiniciar'),
                ),
              ),
            ),
            const SizedBox(height: 30),
            IncidentListPage(key: _incidentListKey)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddIncidentPage,
        child: const Icon(Icons.add),
        ),
    );
  }
}