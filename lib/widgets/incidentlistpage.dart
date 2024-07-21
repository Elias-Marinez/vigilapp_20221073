import 'dart:io';

import 'package:flutter/material.dart';
import '../models/incident_model.dart';

import '../database/database_helper.dart';
import '../pages/incidentdetailpage.dart';

class IncidentListPage extends StatefulWidget{
  const IncidentListPage({super.key});

  @override
  State<IncidentListPage> createState() => IncidentListPageState();
}

class IncidentListPageState extends State<IncidentListPage>{
  late Future<List<Incident>> _incidentList;

  void _loadData() {
    setState(() {
      _incidentList = DatabaseHelper().getIncidents();
    });
  }

  @override
  void initState(){
    super.initState();
    _loadData();
  }

  void refreshData() {
    _loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Incident>>(
        future: _incidentList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No hay incidencias registradas.');
          } else {
            final incidents = snapshot.data!;
            return ListView.builder(
              itemCount: incidents.length,
              itemBuilder: (context, index) {
                final incident = incidents[index];
                return Card(
                  elevation: 2,
                  color: Color.fromARGB(115, 70, 70, 70),
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: incident.photo != null ? FileImage(File(incident.photo!)) : null,
                      child: incident.photo == null ? const Icon(Icons.image, size: 30) : null,
                    ),
                    title: Text(
                      incident.title,
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    subtitle: Text(
                      incident.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IncidentDetailPage(incident: incident),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}