import 'package:fit_flow/features/workout/data/models/exercise_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_plan_model.dart';

// ─── Exercises ───────────────────────────────────────────────────────────────

const _benchPress = ExerciseModel(
  id: 'bench_press',
  name: 'Bench Press',
  muscleGroup: 'Chest',
  equipment: 'Barbell',
  formCues: [
    'Retract and depress your shoulder blades.',
    'Plant feet flat on the floor.',
    'Lower the bar to mid-chest with control.',
    'Drive the bar straight up, locking out at the top.',
  ],
);

const _inclineDumbbellPress = ExerciseModel(
  id: 'incline_db_press',
  name: 'Incline Dumbbell Press',
  muscleGroup: 'Chest',
  equipment: 'Dumbbell',
  formCues: [
    'Set bench to 30–45 degrees.',
    'Keep elbows at 45° from your torso.',
    'Press fully without locking elbows aggressively.',
  ],
);

const _cableFly = ExerciseModel(
  id: 'cable_fly',
  name: 'Cable Fly',
  muscleGroup: 'Chest',
  equipment: 'Cable',
  formCues: [
    'Slight bend in the elbows throughout.',
    'Lead with your elbows, not your hands.',
    'Squeeze at full contraction.',
  ],
);

const _overheadPress = ExerciseModel(
  id: 'overhead_press',
  name: 'Overhead Press',
  muscleGroup: 'Shoulders',
  equipment: 'Barbell',
  formCues: [
    'Brace your core and glutes.',
    'Press the bar in a straight line over your head.',
    'Do not hyperextend your lower back.',
  ],
);

const _lateralRaise = ExerciseModel(
  id: 'lateral_raise',
  name: 'Lateral Raise',
  muscleGroup: 'Shoulders',
  equipment: 'Dumbbell',
  formCues: [
    'Slight forward lean and bend in the elbows.',
    'Raise until arms are parallel to the floor.',
    'Control the descent — no swinging.',
  ],
);

const _tricepPushdown = ExerciseModel(
  id: 'tricep_pushdown',
  name: 'Tricep Pushdown',
  muscleGroup: 'Triceps',
  equipment: 'Cable',
  formCues: [
    'Keep elbows pinned to your sides.',
    'Extend fully, squeeze at the bottom.',
    'Slow, controlled return.',
  ],
);

const _pullUp = ExerciseModel(
  id: 'pull_up',
  name: 'Pull-Up',
  muscleGroup: 'Back',
  equipment: 'Bodyweight',
  formCues: [
    'Start from a dead hang with scapulae depressed.',
    'Pull until chin clears the bar.',
    'Lower with control — no dropping.',
  ],
);

const _barbellRow = ExerciseModel(
  id: 'barbell_row',
  name: 'Barbell Row',
  muscleGroup: 'Back',
  equipment: 'Barbell',
  formCues: [
    'Hinge at the hips, back flat and braced.',
    'Pull to your lower chest / upper abdomen.',
    'Keep elbows close and squeeze at the top.',
  ],
);

const _seatedCableRow = ExerciseModel(
  id: 'seated_cable_row',
  name: 'Seated Cable Row',
  muscleGroup: 'Back',
  equipment: 'Cable',
  formCues: [
    'Sit tall with a neutral spine.',
    'Initiate the pull by retracting your shoulder blades.',
    'Full stretch at the front, full retraction at the back.',
  ],
);

const _facePull = ExerciseModel(
  id: 'face_pull',
  name: 'Face Pull',
  muscleGroup: 'Rear Delts',
  equipment: 'Cable',
  formCues: [
    'Set cable to upper-chest height.',
    'Pull to your forehead, elbows flared high.',
    'External-rotate at the end position.',
  ],
);

const _bicepCurl = ExerciseModel(
  id: 'bicep_curl',
  name: 'Bicep Curl',
  muscleGroup: 'Biceps',
  equipment: 'Dumbbell',
  formCues: [
    'Upper arms stay still and pinned to your sides.',
    'Supinate the wrist at the top.',
    'Lower slowly — 2–3 second descent.',
  ],
);

const _squat = ExerciseModel(
  id: 'squat',
  name: 'Squat',
  muscleGroup: 'Quads',
  equipment: 'Barbell',
  formCues: [
    'Brace your core like you\'re about to take a punch.',
    'Break at the hips and knees simultaneously.',
    'Keep knees tracking over toes throughout.',
    'Drive the floor away on the way up.',
  ],
);

const _romanianDeadlift = ExerciseModel(
  id: 'rdl',
  name: 'Romanian Deadlift',
  muscleGroup: 'Hamstrings',
  equipment: 'Barbell',
  formCues: [
    'Push your hips back, not your knees forward.',
    'Bar stays close to the body throughout.',
    'Feel a deep stretch in the hamstrings before reversing.',
  ],
);

const _legPress = ExerciseModel(
  id: 'leg_press',
  name: 'Leg Press',
  muscleGroup: 'Quads',
  equipment: 'Machine',
  formCues: [
    'Place feet shoulder-width, mid-platform.',
    'Do not lock knees at the top.',
    'Lower until legs reach ~90 degrees.',
  ],
);

const _calfRaise = ExerciseModel(
  id: 'calf_raise',
  name: 'Calf Raise',
  muscleGroup: 'Calves',
  equipment: 'Machine',
  formCues: [
    'Full range: from a deep stretch to full contraction.',
    'Pause briefly at the top.',
    'Control the descent.',
  ],
);

// ─── Plan ────────────────────────────────────────────────────────────────────

const WorkoutPlanModel beginnerPPL = WorkoutPlanModel(
  id: 'beginner_ppl',
  name: 'Beginner Push / Pull / Legs',
  days: [
    WorkoutDayModel(
      name: 'Push',
      workoutDays: [1, 4], // Mon, Thu
      exercises: [
        WorkoutDayExercise(exercise: _benchPress, defaultSets: 3, defaultReps: 8),
        WorkoutDayExercise(exercise: _inclineDumbbellPress, defaultSets: 3, defaultReps: 10),
        WorkoutDayExercise(exercise: _cableFly, defaultSets: 3, defaultReps: 12),
        WorkoutDayExercise(exercise: _overheadPress, defaultSets: 3, defaultReps: 8),
        WorkoutDayExercise(exercise: _lateralRaise, defaultSets: 3, defaultReps: 15),
        WorkoutDayExercise(exercise: _tricepPushdown, defaultSets: 3, defaultReps: 12),
      ],
    ),
    WorkoutDayModel(
      name: 'Pull',
      workoutDays: [2, 5], // Tue, Fri
      exercises: [
        WorkoutDayExercise(exercise: _pullUp, defaultSets: 3, defaultReps: 6),
        WorkoutDayExercise(exercise: _barbellRow, defaultSets: 3, defaultReps: 8),
        WorkoutDayExercise(exercise: _seatedCableRow, defaultSets: 3, defaultReps: 10),
        WorkoutDayExercise(exercise: _facePull, defaultSets: 3, defaultReps: 15),
        WorkoutDayExercise(exercise: _bicepCurl, defaultSets: 3, defaultReps: 12),
      ],
    ),
    WorkoutDayModel(
      name: 'Legs',
      workoutDays: [3, 6], // Wed, Sat
      exercises: [
        WorkoutDayExercise(exercise: _squat, defaultSets: 3, defaultReps: 6),
        WorkoutDayExercise(exercise: _romanianDeadlift, defaultSets: 3, defaultReps: 8),
        WorkoutDayExercise(exercise: _legPress, defaultSets: 3, defaultReps: 10),
        WorkoutDayExercise(exercise: _calfRaise, defaultSets: 4, defaultReps: 15),
      ],
    ),
  ],
);
