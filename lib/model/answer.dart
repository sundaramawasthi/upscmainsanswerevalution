class Answer {
  final String id;
  final String userId;
  final String questionId;
  final String type; // 'richtext' or 'pdf'
  final String fileUrl; // for PDF/image uploads
  final List<String> submittedKeywords;
  final String? submittedText;
  final DateTime date;

  Answer({
    required this.id,
    required this.userId,
    required this.questionId,
    required this.type,
    required this.fileUrl,
    required this.submittedKeywords,
    this.submittedText,
    required this.date,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      userId: json['userId'],
      questionId: json['questionId'],
      type: json['type'],
      fileUrl: json['fileUrl'],
      submittedKeywords: List<String>.from(json['submittedKeywords']),
      submittedText: json['submittedText'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'questionId': questionId,
      'type': type,
      'fileUrl': fileUrl,
      'submittedKeywords': submittedKeywords,
      'submittedText': submittedText,
      'date': date.toIso8601String(),
    };
  }
}
