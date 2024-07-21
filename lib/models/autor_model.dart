class Autor {
  final String name;
  final String photoUrl;
  final String registrationNumber;
  final String phrase;

  Autor({
    required this.name,
    required this.photoUrl,
    required this.registrationNumber,
    required this.phrase,
  });
}

final Autor autor = Autor(
    name: 'Elias Mariñez',
    photoUrl: 'assets/images/profile.jpg',
    registrationNumber: '2022-1073',
    phrase: 'Una onza de prevención vale más que una libra de cura.',
  );