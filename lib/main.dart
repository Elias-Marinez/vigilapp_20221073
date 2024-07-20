import 'package:flutter/material.dart';
import 'package:vigilapp_20221073/pages/homepage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    var textColor = Colors.white;
    var appBarBgColor =  const Color.fromARGB(255, 3, 0, 23);
    var bodybgColor = const Color.fromARGB(255, 17, 19, 20);
    var accentColor = const Color(0xFFF5F5F5);

    return MaterialApp(
      title: 'VigilApp',
      theme: ThemeData(
        primaryColor: textColor,
        scaffoldBackgroundColor: bodybgColor,
        textTheme: TextTheme(
          bodySmall: TextStyle(color: textColor ),
          bodyMedium: TextStyle(color: textColor),
          bodyLarge: TextStyle(color:textColor )
        ), // Color de fondo predeterminado para Scaffold
        appBarTheme: AppBarTheme(
          foregroundColor: textColor,
          backgroundColor: appBarBgColor, // Fondo del AppBar
          iconTheme: IconThemeData(color: accentColor), // Color de los íconos del AppBar
          ),
        iconTheme: IconThemeData(color: appBarBgColor), // Color de los íconos en general
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: appBarBgColor,
          foregroundColor: textColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(appBarBgColor),
            foregroundColor: WidgetStateProperty.all(textColor),
          ),
        ),
      ),
      home: const Homepage(),
    );
  }
}


