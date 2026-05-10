const canonicalMuscleGroups = <String>{
  'chest',
  'back',
  'legs',
  'shoulders',
  'core',
  'biceps',
  'triceps',
  'glutes',
  'hamstrings',
  'quads',
  'posterior_chain',
};

const canonicalEquipment = <String>{
  'barbell',
  'dumbbell',
  'machine',
  'cable',
  'bodyweight',
  'kettlebell',
};

const canonicalDifficulty = <String>{
  'beginner',
  'intermediate',
  'advanced',
};

const canonicalExerciseCategories = <String>{
  'compound',
  'isolation',
  'cardio',
  'mobility',
};

const canonicalLearnCategories = <String, String>{
  'nutrition': 'التغذية',
  'training': 'التدريب',
  'recovery': 'التعافي',
  'fat_loss': 'خسارة الدهون',
  'supplements': 'المكملات',
  'beginner_fitness': 'لياقة للمبتدئين',
};

const exerciseDuplicateMap = <String, String>{
  'burpees': 'burpee',
  'dips': 'dip',
  'crunches': 'crunch',
  'pullup': 'pull_up',
  'pullups': 'pull_up',
  'pushups': 'push_up',
  'barbell_squat': 'squat',
  'incline_db_press': 'incline_dumbbell_press',
  'rdl': 'romanian_deadlift',
  'skull_crushers': 'skull_crusher',
  'tricep_pushdown': 'tricep_rope_pushdown',
};

const removableExerciseMediaFields = <String>{
  'videoUrl',
  'thumbnailUrl',
  'imageUrl',
  'gifUrl',
};

String canonicalExerciseId(String id) {
  return exerciseDuplicateMap[id] ?? id;
}

String normalizeEnumValue(String raw) {
  return raw.trim().toLowerCase().replaceAll(' ', '_');
}

bool isCorruptedArabicText(String value) {
  return value.contains('╪') || value.contains('┘') || value.contains('ΓÇ');
}