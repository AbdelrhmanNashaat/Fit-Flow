class LocalizedText {
  const LocalizedText({required this.en, required this.ar});

  final String en;
  final String ar;

  Map<String, dynamic> toJson() {
    return {'en': en, 'ar': ar};
  }
}

class LocalizedTextList {
  const LocalizedTextList({required this.en, required this.ar});

  final List<String> en;
  final List<String> ar;

  Map<String, dynamic> toJson() {
    return {'en': en, 'ar': ar};
  }
}

class NormalizedExerciseDocument {
  const NormalizedExerciseDocument({
    required this.id,
    required this.muscleGroup,
    required this.equipment,
    required this.difficulty,
    required this.category,
    required this.defaultSets,
    required this.defaultReps,
    required this.name,
    required this.description,
    required this.instructions,
    required this.secondaryMuscles,
  });

  final String id;
  final String muscleGroup;
  final String equipment;
  final String difficulty;
  final String category;
  final int defaultSets;
  final String defaultReps;
  final LocalizedText name;
  final LocalizedText description;
  final LocalizedTextList instructions;
  final List<String> secondaryMuscles;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'muscleGroup': muscleGroup,
      'equipment': equipment,
      'difficulty': difficulty,
      'category': category,
      'defaultSets': defaultSets,
      'defaultReps': defaultReps,
      'name': name.toJson(),
      'description': description.toJson(),
      'instructions': instructions.toJson(),
      'secondaryMuscles': secondaryMuscles,
    };
  }
}

class WorkoutTemplateExerciseDocument {
  const WorkoutTemplateExerciseDocument({
    required this.exerciseId,
    required this.sets,
    required this.reps,
  });

  final String exerciseId;
  final int sets;
  final String reps;

  Map<String, dynamic> toJson() {
    return {'exerciseId': exerciseId, 'sets': sets, 'reps': reps};
  }
}

class WorkoutTemplateDayDocument {
  const WorkoutTemplateDayDocument({
    required this.dayIndex,
    required this.name,
    required this.exercises,
  });

  final int dayIndex;
  final LocalizedText name;
  final List<WorkoutTemplateExerciseDocument> exercises;

  Map<String, dynamic> toJson() {
    return {
      'dayIndex': dayIndex,
      'name': name.toJson(),
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    };
  }
}

class NormalizedWorkoutTemplateDocument {
  const NormalizedWorkoutTemplateDocument({
    required this.id,
    required this.goal,
    required this.daysPerWeek,
    required this.name,
    required this.description,
    required this.days,
  });

  final String id;
  final String goal;
  final int daysPerWeek;
  final LocalizedText name;
  final LocalizedText description;
  final List<WorkoutTemplateDayDocument> days;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'goal': goal,
      'daysPerWeek': daysPerWeek,
      'name': name.toJson(),
      'description': description.toJson(),
      'days': days.map((day) => day.toJson()).toList(),
    };
  }
}

class NormalizedLearnDocument {
  const NormalizedLearnDocument({
    required this.id,
    required this.category,
    required this.title,
    required this.content,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  final String id;
  final LocalizedText category;
  final LocalizedText title;
  final LocalizedText content;
  final String videoUrl;
  final String thumbnailUrl;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category.toJson(),
      'title': title.toJson(),
      'content': content.toJson(),
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}

class CurrentPlanDocument {
  const CurrentPlanDocument({
    required this.templateId,
    required this.goal,
    required this.daysPerWeek,
    required this.startedAt,
  });

  final String templateId;
  final String goal;
  final int daysPerWeek;
  final String startedAt;

  Map<String, dynamic> toJson() {
    return {
      'templateId': templateId,
      'goal': goal,
      'daysPerWeek': daysPerWeek,
      'startedAt': startedAt,
    };
  }
}

class PerformedSetDocument {
  const PerformedSetDocument({
    required this.setNumber,
    required this.reps,
    required this.weight,
    required this.isCompleted,
  });

  final int setNumber;
  final int reps;
  final num weight;
  final bool isCompleted;

  Map<String, dynamic> toJson() {
    return {
      'setNumber': setNumber,
      'reps': reps,
      'weight': weight,
      'isCompleted': isCompleted,
    };
  }
}

class CompletedExerciseDocument {
  const CompletedExerciseDocument({
    required this.exerciseId,
    required this.isCompleted,
    required this.targetSets,
    required this.targetReps,
    required this.performedSets,
  });

  final String exerciseId;
  final bool isCompleted;
  final int targetSets;
  final String targetReps;
  final List<PerformedSetDocument> performedSets;

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'isCompleted': isCompleted,
      'targetSets': targetSets,
      'targetReps': targetReps,
      'performedSets': performedSets.map((set) => set.toJson()).toList(),
    };
  }
}

class WorkoutSessionDocument {
  const WorkoutSessionDocument({
    required this.id,
    required this.templateId,
    required this.workoutDay,
    required this.scheduledDate,
    required this.completedAt,
    required this.status,
    required this.durationInMinutes,
    required this.completedExercises,
  });

  final String id;
  final String templateId;
  final LocalizedText workoutDay;
  final String scheduledDate;
  final String? completedAt;
  final String status;
  final int durationInMinutes;
  final List<CompletedExerciseDocument> completedExercises;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'templateId': templateId,
      'workoutDay': workoutDay.toJson(),
      'scheduledDate': scheduledDate,
      'completedAt': completedAt,
      'status': status,
      'durationInMinutes': durationInMinutes,
      'completedExercises': completedExercises
          .map((exercise) => exercise.toJson())
          .toList(),
    };
  }
}

class ExerciseProgressDocument {
  const ExerciseProgressDocument({
    required this.exerciseId,
    required this.bestWeight,
    required this.bestReps,
    required this.lastWeight,
    required this.lastPerformedAt,
    required this.totalVolume,
  });

  final String exerciseId;
  final num bestWeight;
  final int bestReps;
  final num lastWeight;
  final String? lastPerformedAt;
  final num totalVolume;

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'bestWeight': bestWeight,
      'bestReps': bestReps,
      'lastWeight': lastWeight,
      'lastPerformedAt': lastPerformedAt,
      'totalVolume': totalVolume,
    };
  }
}

class WorkoutCalendarEntryDocument {
  const WorkoutCalendarEntryDocument({
    required this.date,
    required this.templateId,
    required this.dayIndex,
    required this.workoutDay,
    required this.status,
    required this.sessionId,
  });

  final String date;
  final String templateId;
  final int dayIndex;
  final LocalizedText workoutDay;
  final String status;
  final String? sessionId;

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'templateId': templateId,
      'dayIndex': dayIndex,
      'workoutDay': workoutDay.toJson(),
      'status': status,
      'sessionId': sessionId,
    };
  }
}