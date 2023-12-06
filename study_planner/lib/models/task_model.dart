class Task {
  final String title;
  final DateTime date;
  bool isCompleted;
  bool isHabit;
  bool isWeekTask;

  Task({
    required this.title,
    required this.date,
    this.isCompleted = false,
    this.isHabit = false,
    this.isWeekTask = false,
  });
}