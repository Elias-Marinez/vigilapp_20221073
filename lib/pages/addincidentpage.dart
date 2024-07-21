import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import '../database/database_helper.dart';
import '../models/incident_model.dart';

class AddIncidentPage extends StatefulWidget{
  const AddIncidentPage({super.key});

  @override
  AddIncidentPageState createState() => AddIncidentPageState();
}

class AddIncidentPageState extends State<AddIncidentPage>{
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _imageFile;
  String? _audioFilePath;

  final _record = Record();
  bool _isRecording = false;

  Future<void> _requestPermissions() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      log('Permiso de grabación de audio denegado.');
    }
  }

  @override
  void initState(){
    super.initState();
    _requestPermissions();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if(pickedFile != null){
        _imageFile = File(pickedFile!.path);
      }
    });
  }

  Future<void> _startRecording() async {
    try {
      final directory = await Directory.systemTemp.createTemp();
      final path = '${directory.path}/audio.m4a';

      //Inicio de la grabación
      await _record.start(
        path: path,
        encoder: AudioEncoder.aacLc
        );
        
      setState(() {
        _isRecording = true;
        _audioFilePath = path;
      });
    }catch (e){
      log("Error al iniciar la grabación: $e");
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _record.stop();
      setState(() {
        _isRecording = false;
        _audioFilePath = path;
      });
    } catch (e) {
      log("Error al detener la grabación: $e");
    }
  }

  Future<void> _saveIncident() async {

    if(_isRecording) _stopRecording();
    
    final incident = Incident(
      title: _titleController.text,
      date: DateTime.now().toString(),
      description: _descriptionController.text,
      photo: _imageFile?.path,
      audio: _audioFilePath
      );

      await DatabaseHelper().insertIncident(incident);

      if(mounted){
        Navigator.pop(context, true);
      }
  }

  @override
  void dispose() {
     _record.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: const Text('Registrar Incidente')
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Por favor ingrese un titulo';
                  }else{
                    return null;
                  }
                }
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Por favor ingrese una descripcion';
                  }else{
                    return null;
                  }
                }
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _imageFile == null
                    ? const Text('Tome una Imagen.')
                    : Image.file(_imageFile!, width: 100),
                  ElevatedButton(
                    onPressed: _pickImage,
                     child: const Padding(
                       padding: EdgeInsets.all(12.0),
                       child: Text('Tomar una foto'),
                     )
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _isRecording
                    ? const Text('Grabando audio....')
                    : _audioFilePath == null
                      ? const Text('No ha grabado audio.')
                      : const Text('El audio ha sido grabado.'),
                  ElevatedButton(
                    onPressed: _isRecording ? _stopRecording : _startRecording,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(_isRecording ? 'Detener Grabacion' : 'Grabar Audio'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveIncident, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 2, 80, 119), // Cambia el color de fondo del botón
                    foregroundColor: Colors.white, // Cambia el color del texto del botón
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Guardar Incidente'),
                  )
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}