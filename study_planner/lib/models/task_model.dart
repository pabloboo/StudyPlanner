class Task {
  final String title;
  final DateTime date;
  final String email;
  bool isCompleted;
  bool isHabit;
  bool isWeekTask;

  Task({
    required this.title,
    required this.date,
    required this.email,
    this.isCompleted = false,
    this.isHabit = false,
    this.isWeekTask = false,
  });

  Map<String, dynamic> toJson() { //Task to JSON
    return {
      'title': title,
      'date': date.toIso8601String(),
      'email': email,
      'isCompleted': isCompleted,
      'isHabit': isHabit,
      'isWeekTask': isWeekTask,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) { // JSON to Task
    return Task(
      title: json['title'],
      date: DateTime.parse(json['date']),
      email: json['email'],
      isCompleted: json['isCompleted'],
      isHabit: json['isHabit'],
      isWeekTask: json['isWeekTask'],
    );
  }
}