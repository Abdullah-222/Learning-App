import 'package:flutter/material.dart';
import 'package:secure_learning_app/constants.dart';
import 'package:secure_learning_app/models/topic_model.dart';
import 'package:secure_learning_app/screens/video_screen.dart';
import 'package:secure_learning_app/services/progress_service.dart';

class QuizScreen extends StatefulWidget {
  final Topic topic;

  const QuizScreen({super.key, required this.topic});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  bool _isAnswered = false;
  int _score = 0;

  void _checkAnswer() {
    if (_selectedOptionIndex == null) return;

    setState(() {
      _isAnswered = true;
      if (_selectedOptionIndex == widget.topic.questions[_currentQuestionIndex].correctIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < widget.topic.questions.length - 1) {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
        _isAnswered = false;
      } else {
        // Quiz Finished
        _showCompletionDialog();
      }
    });
  }
  


// ...

  void _showCompletionDialog() async {
    // Save Progress
    await ProgressService().saveProgress(widget.topic.id, _score);

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Lesson Complete!'),
          content: Text('You scored $_score out of ${widget.topic.questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Close screen
              },
              child: const Text('Finish'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchVideo() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoScreen(topic: widget.topic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.topic.questions.isEmpty) {
        return Scaffold(appBar: AppBar(), body: const Center(child: Text("No questions for this topic")));
    }

    final question = widget.topic.questions[_currentQuestionIndex];
    final theme = Theme.of(context);

    // Calc progress
    final progress = (_currentQuestionIndex + 1) / widget.topic.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic.title),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
            IconButton(
                icon: const Icon(Icons.play_circle_fill, color: Colors.blue),
                onPressed: _launchVideo,
                tooltip: 'Watch Video Lesson',
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Progress Bar
                    LinearProgressIndicator(
              value: progress,
              color: AppColors.primaryGreen,
              backgroundColor: theme.dividerColor,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Text(
              'Question ${_currentQuestionIndex + 1} of ${widget.topic.questions.length}',
              textAlign: TextAlign.right,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 32),

            // Question Text
            Text(
              question.question,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 32),

            // Options
            ...List.generate(question.options.length, (index) {
              final isSelected = _selectedOptionIndex == index;
              final isCorrect = index == question.correctIndex;
              
              Color borderColor = theme.dividerColor;
              Color? bgColor = theme.cardTheme.color;
              
              if (_isAnswered) {
                  if (isCorrect) {
                      borderColor = Colors.green;
                      bgColor = Colors.green.withValues(alpha: 0.1);
                  } else if (isSelected) {
                      borderColor = Colors.red;
                      bgColor = Colors.red.withValues(alpha: 0.1);
                  }
              } else if (isSelected) {
                  borderColor = AppColors.primaryGreen;
                  bgColor = AppColors.primaryGreen.withValues(alpha: 0.05);
              }


              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: _isAnswered ? null : () {
                    setState(() {
                      _selectedOptionIndex = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: bgColor,
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                        children: [
                             if (_isAnswered && isCorrect)
                                const Icon(Icons.check_circle, color: Colors.green)
                             else if (_isAnswered && isSelected && !isCorrect)
                                const Icon(Icons.cancel, color: Colors.red)
                             else
                                Icon(
                                    isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                    color: isSelected ? AppColors.primaryGreen : Colors.grey,
                                ),
                             const SizedBox(width: 16),
                             Expanded(child: Text(question.options[index], style: theme.textTheme.bodyMedium)),
                        ],
                    ),
                  ),
                ),
              );
            }),

            // Feedback / Explanation
            if (_isAnswered)
                Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                                _selectedOptionIndex == question.correctIndex ? 'Correct!' : 'Incorrect',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _selectedOptionIndex == question.correctIndex ? Colors.green : Colors.red,
                                ),
                            ),
                            const SizedBox(height: 4),
                            Text(question.explanation),
                        ],
                    ),
                ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Button
            ElevatedButton(
              onPressed: _selectedOptionIndex == null 
                  ? null 
                  : (_isAnswered ? _nextQuestion : _checkAnswer),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(_isAnswered 
                ? (_currentQuestionIndex == widget.topic.questions.length - 1 ? 'Finish' : 'Next Question') 
                : 'Check Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
