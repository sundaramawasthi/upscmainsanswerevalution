class Question {
  final String id;
  final String text;
  final String paper; // e.g., 'GS1', 'GS2', 'Essay'
  final List<String> tags;
  final DateTime date;

  Question({
    required this.id,
    required this.text,
    required this.paper,
    required this.tags,
    required this.date,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      text: json['text'],
      paper: json['paper'],
      tags: List<String>.from(json['tags']),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'paper': paper,
      'tags': tags,
      'date': date.toIso8601String(),
    };
  }
}
