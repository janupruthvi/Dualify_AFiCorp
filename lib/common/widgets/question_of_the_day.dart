import 'package:dualify_apprenticeship_aficorp/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../../models/question.dart';

class QuestionOfTheDay extends StatefulWidget {
  final Question question;
  final void Function(String answer)? onAnswer;

  const QuestionOfTheDay({super.key, required this.question, this.onAnswer});

  @override
  State<QuestionOfTheDay> createState() => _QuestionOfTheDayState();
}

class _QuestionOfTheDayState extends State<QuestionOfTheDay> {
  final TextEditingController _controller = TextEditingController();
  bool _submitted = false;
  String? _answer;

  @override
  void initState() {
    super.initState();
    if (widget.question.answer != null) {
      _controller.text = widget.question.answer!;
      _answer = widget.question.answer!;
      _submitted = true;
    }
  }

  void _submitAnswer() {
    setState(() {
      _answer = _controller.text;
      _submitted = true;
    });
    if (widget.onAnswer != null) {
      widget.onAnswer!(_controller.text);
    }
  }

  void _editAnswer() {
    setState(() {
      _submitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question.text,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _submitted
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          _answer ?? '',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        tooltip: 'Edit answer',
                        onPressed: _editAnswer,
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomTextField(
                        controller: _controller,
                        label: "Answer",
                        hint: "Your answer or emoji",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter an answer";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _submitAnswer,
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Community',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'What was your mood boost today at work or at school? #spillthetea',
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
