// Question model for "Question of the Day"

class Question {
  final String text;
  final String? answer;

  Question({
    required this.text,
    this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'answer': answer,
    };
  }
}
