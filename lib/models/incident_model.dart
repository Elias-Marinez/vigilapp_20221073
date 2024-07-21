class Incident {
  int? id;
  String title;
  String date;
  String description;
  String? photo;
  String? audio;

  Incident({ 
    this.id, 
    required this.title,
    required this.date,
    required this.description,
    this.photo,
    this.audio 
    });

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'title': title,
      'date': date,
      'description': description,
      'photo': photo,
      'audio': audio
    };
  }

  factory Incident.fromMap(Map<String, dynamic> map){
    return Incident(
      id: map['id'],
      title: map['title'], 
      date: map['date'], 
      description: map['description'],
      photo: map['photo'],
      audio: map['audio']
      );
  }
}