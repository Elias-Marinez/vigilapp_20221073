import 'package:flutter/material.dart';

class Homepage extends StatelessWidget{

  const Homepage({super.key});
  
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
        onPressed: () { },
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