class ExerciseModel {
  const ExerciseModel({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.equipment,
    required this.formCues,
    this.imageAsset,
  });

  final String id;
  final String name;
  final String muscleGroup;
  final String equipment;
  final List<String> formCues;
  final String? imageAsset;
}
