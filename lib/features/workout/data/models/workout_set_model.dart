class WorkoutSetModel {
  const WorkoutSetModel({
    required this.setNumber,
    required this.reps,
    this.weightKg,
    this.isCompleted = false,
  });

  final int setNumber;
  final String reps;
  final double? weightKg;
  final bool isCompleted;

  WorkoutSetModel copyWith({
    int? setNumber,
    String? reps,
    double? weightKg,
    bool? isCompleted,
  }) {
    return WorkoutSetModel(
      setNumber: setNumber ?? this.setNumber,
      reps: reps ?? this.reps,
      weightKg: weightKg ?? this.weightKg,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
