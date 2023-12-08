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

  Map<String, dynamic> toJson() { //Task to JSON
    return {
      'title': title,
      'date': date.toIso8601String(),
      'isCompleted': isCompleted,
      'isHabit': isHabit,
      'isWeekTask': isWeekTask,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) { // JSON to Task
    return Task(
      title: json['title'],
      date: DateTime.parse(json['date']),
      isCompleted: json['isCompleted'],
      isHabit: json['isHabit'],
      isWeekTask: json['isWeekTask'],
    );
  }
}