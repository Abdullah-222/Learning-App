class Topic {
  final String id;
  final String title;
  final String description;
  final String iconAsset; // Or use IconData for now if no assets
  final String videoUrl;
  final List<QuizQuestion> questions;

  const Topic({
    required this.id,
    required this.title,
    required this.description,
    required this.iconAsset,
    required this.videoUrl,
    required this.questions,
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}
