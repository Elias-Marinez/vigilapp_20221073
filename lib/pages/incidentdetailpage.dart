import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../models/incident_model.dart';

class IncidentDetailPage extends StatefulWidget {
  final Incident incident;
  
  const IncidentDetailPage({super.key, required this.incident});

  @override
  State<IncidentDetailPage> createState() => _IncidentDetailPageState();
}

class _IncidentDetailPageState extends State<IncidentDetailPage> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState(){
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playPauseAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      if (widget.incident.audio != null) {
        await _audioPlayer.play(DeviceFileSource(widget.incident.audio!));
      }    
    }
    setState(() {
      if (widget.incident.audio != null) _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Incidencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (widget.incident.photo != null) 
              Center(
                child: Image.file(
                  File(widget.incident.photo!),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                widget.incident.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Fecha:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Text(
                widget.incident.date, // Convert DateTime to String
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Descripción:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.incident.description,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 30),
            if (widget.incident.audio != null)
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  label: Text(_isPlaying ? 'Pausar Audio' : 'Reproducir Audio'),
                  onPressed: _playPauseAudio,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50), // Full-width button
                    padding: const EdgeInsets.symmetric(vertical: 12.0), // Padding inside button
                    textStyle: const TextStyle(fontSize: 16), // Increase font size
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}