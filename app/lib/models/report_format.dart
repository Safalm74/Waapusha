class Album {
  final String disease;
  final String overview;
  final String preventive_measure;
  final String symptoms;
  final String solution;
  final String segmented_image;

  const Album({
    required this.disease,
    required this.overview,
    required this.preventive_measure,
    required this.symptoms,
    required this.solution,
    required this.segmented_image,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      disease: json['disease'],
      overview: json['overview'],
      preventive_measure: json['preventive_measure'],
      symptoms: json['symptoms'],
      solution: json['solution'],
      segmented_image: json['segmented_image'],
    );
  }
}
