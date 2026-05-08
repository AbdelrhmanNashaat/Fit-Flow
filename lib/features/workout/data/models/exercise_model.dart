class ExerciseModel {
  const ExerciseModel({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.equipment,
    required this.formCues,
    this.imageAsset,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      muscleGroup: json['muscleGroup'] as String? ?? '',
      equipment: json['equipment'] as String? ?? '',
      formCues: List<String>.from(
        json['formCues'] as List<dynamic>? ?? const [],
      ),
      imageAsset: json['imageAsset'] as String?,
    );
  }

  final String id;
  final String name;
  final String muscleGroup;
  final String equipment;
  final List<String> formCues;
  final String? imageAsset;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'muscleGroup': muscleGroup,
      'equipment': equipment,
      'formCues': formCues,
      'imageAsset': imageAsset,
    };
  }
}
