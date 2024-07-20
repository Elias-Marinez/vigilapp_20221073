import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vigilapp_20221073/pages/addincidentpage.dart';

class Homepage extends StatefulWidget{

  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  Future<void> _navigateToAddIncidentPage() async{
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddIncidentPage()
      )
    );

    result ? log('Se ha agregado un incidente') : log('no se ha agregado incidente');
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddIncidentPage,
        child: const Icon(Icons.add),
        ),
    );
  }

    void _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const Text('Are you sure you want to proceed?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                _executeAction(); // Ejecuta la acción
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _executeAction() {
    // Aquí defines la acción a ejecutar si el usuario selecciona "Sí"
  }
}