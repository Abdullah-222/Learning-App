import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_learning_app/constants.dart';
import 'package:secure_learning_app/data/topics_data.dart';
import 'package:secure_learning_app/models/topic_model.dart';
import 'package:secure_learning_app/screens/quiz_screen.dart';
import 'package:secure_learning_app/screens/video_screen.dart';
import 'package:secure_learning_app/services/progress_service.dart';
import 'package:secure_learning_app/controllers/settings_controller.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.watch<SettingsController>();
    
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                // Custom Header
                Container(
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                    decoration: BoxDecoration(
                        color: AppColors.primaryGreen,
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                        boxShadow: [
                            BoxShadow(
                                color: AppColors.primaryGreen.withValues(alpha: 0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                            )
                        ]
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                                controller.language == 'Arabic' ? 'تعلم' : 'Learn',
                                style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                ),
                            ),
                             const SizedBox(height: 8),
                            Text(
                                controller.language == 'Arabic' ? 'إتقان مفاهيم الترميز الآمن' : 'Master secure coding concepts',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withValues(alpha: 0.8),
                                ),
                            ),
                        ],
                    ),
                ),

                // Content
                Expanded(
                    child: ListView.separated(
                        padding: const EdgeInsets.all(24),
                        itemCount: TopicsData.topics.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                            final topic = TopicsData.topics[index];
                            return _TopicCard(topic: topic);
                        },
                    ),
                ),
            ],
        ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final Topic topic;

  const _TopicCard({required this.topic});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FutureBuilder<int>(
      future: ProgressService().getProgress(topic.id),
      builder: (context, snapshot) {
        final score = snapshot.data ?? 0;
        final total = topic.questions.length;
        final percent = total > 0 ? score / total : 0.0;
        final progressText = '$score/$total Questions';

        return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.dividerColor),
                 boxShadow: [
                     BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                    )
                 ]
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Row(
                        children: [
                            Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryGreen.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(Icons.code, color: AppColors.primaryGreen), 
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                                Text(
                                                    topic.title,
                                                    style: theme.textTheme.titleMedium?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                    ),
                                                ),
                                                IconButton(
                                                    icon: const Icon(Icons.refresh, size: 20),
                                                    tooltip: 'Restart Topic',
                                                    onPressed: () async {
                                                        final confirm = await showDialog<bool>(
                                                            context: context,
                                                            builder: (context) => AlertDialog(
                                                                title: const Text('Restart Topic?'),
                                                                content: const Text('This will clear your progress for this topic.'),
                                                                actions: [
                                                                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                                                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Restart', style: TextStyle(color: Colors.red))),
                                                                ],
                                                            ),
                                                        );
                                                        if (confirm == true) {
                                                            await ProgressService().resetProgress(topic.id);
                                                            // Trigger rebuild
                                                            if (context.mounted) {
                                                                (context as Element).markNeedsBuild();
                                                            }
                                                        }
                                                    },
                                                ),
                                            ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                            progressText, 
                                            style: theme.textTheme.bodySmall,
                                        ),
                                    ],
                                ),
                            ),
                        ],
                     ),
                     const SizedBox(height: 16),
                     Text(
                         topic.description,
                         style: theme.textTheme.bodyMedium,
                     ),
                     const SizedBox(height: 16),
                     ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                            value: percent,
                            backgroundColor: const Color(0xFFF3F4F6),
                            color: AppColors.primaryGreen,
                            minHeight: 8,
                        ),
                    ),
                     const SizedBox(height: 16),
                     Row(
                         children: [
                             Expanded(
                                 child: OutlinedButton.icon(
                                     onPressed: () {
                                         Navigator.push(context, MaterialPageRoute(builder: (_) => VideoScreen(topic: topic)));
                                     },
                                     icon: const Icon(Icons.play_circle_outline, color: AppColors.primaryGreen),
                                     label: const Text('Watch Video', style: TextStyle(color: AppColors.primaryGreen)),
                                     style: OutlinedButton.styleFrom(
                                         side: const BorderSide(color: AppColors.primaryGreen),
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(8),
                                         ),
                                         padding: const EdgeInsets.symmetric(vertical: 12),
                                     ),
                                 ),
                             ),
                             const SizedBox(width: 12),
                             Expanded(
                                 child: ElevatedButton(
                                     onPressed: () async {
                                         await Navigator.push(context, MaterialPageRoute(builder: (_) => QuizScreen(topic: topic)));
                                         // To force refresh we would need state or a stream
                                     },
                                     style: ElevatedButton.styleFrom(
                                         backgroundColor: AppColors.primaryGreen,
                                         foregroundColor: Colors.white,
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(8),
                                         ),
                                         padding: const EdgeInsets.symmetric(vertical: 12),
                                     ),
                                     child: const Text('Start Lesson'),
                                 ),
                             ),
                         ],
                     ),
                ],
            ),
        );
      }
    );
  }
}
