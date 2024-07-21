import 'package:flutter/material.dart';
import '../models/autor_model.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de', style: TextStyle(fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.black, // Fondo de título de sección
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.only(top: 10, bottom: 5),
              child: const Text(
                '    Oficial Activo...',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato', // Cambia 'Lato' a la familia de fuentes que prefieras
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(autor.photoUrl), // Asegúrate de que la imagen esté correctamente registrada
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Column(
                children: [
                  Text(
                    autor.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    autor.registrationNumber,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(autor.phrase),
            ),
          ],
        ),
      ),
    );
  }
}
