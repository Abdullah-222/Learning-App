import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_learning_app/constants.dart';
import 'package:secure_learning_app/controllers/settings_controller.dart';
import 'package:secure_learning_app/controllers/auth_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsController>();
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            // Header
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                        'Preferences',
                        style: textTheme.headlineMedium,
                    ),
                    const CircleAvatar(
                        backgroundColor: Color(0xFFD7F5E8),
                        child: Text('JD', style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
                    ),
                ],
            ),
            const SizedBox(height: 24),

            // Theme Card
            _SettingsCard(
                title: 'Theme',
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text('Select your theme', style: textTheme.bodySmall),
                        const SizedBox(height: 8),
                        RadioListTile<ThemeMode>(
                            title: const Text('Light'),
                            value: ThemeMode.light,
                            groupValue: controller.themeMode,
                            onChanged: controller.updateThemeMode,
                            contentPadding: EdgeInsets.zero,
                            activeColor: AppColors.primaryGreen, 
                        ),
                        RadioListTile<ThemeMode>(
                            title: const Text('Dark'),
                            value: ThemeMode.dark,
                            groupValue: controller.themeMode,
                            onChanged: controller.updateThemeMode,
                            contentPadding: EdgeInsets.zero,
                            activeColor: AppColors.primaryGreen,
                        ),
                        RadioListTile<ThemeMode>(
                            title: const Text('System Default'),
                            value: ThemeMode.system,
                            groupValue: controller.themeMode,
                            onChanged: controller.updateThemeMode,
                            contentPadding: EdgeInsets.zero,
                            activeColor: AppColors.primaryGreen,
                        ),
                    ],
                ),
            ),
            const SizedBox(height: 16),

            // Language & Region
             _SettingsCard(
                title: 'Language & Region',
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text('Language', style: textTheme.bodySmall),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                            value: controller.language,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            ),
                            items: const [
                                DropdownMenuItem(value: 'English', child: Text('English')),
                                DropdownMenuItem(value: 'Arabic', child: Text('Arabic')),
                            ],
                            onChanged: controller.updateLanguage,
                        ),
                    ],
                ),
            ),
            const SizedBox(height: 16),

             // Accessibility
             _SettingsCard(
                title: 'Accessibility',
                child: Column(
                    children: [
                        SwitchListTile(
                            title: const Text('High Contrast Mode', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                            value: controller.highContrast,
                            onChanged: controller.updateHighContrast,
                            contentPadding: EdgeInsets.zero,
                            activeTrackColor: AppColors.primaryGreen,
                        ),
                        const SizedBox(height: 16),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        const Text('Font Size', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                        Text('${(controller.fontSize * 100).toInt()}%', style: textTheme.bodySmall),
                                    ],
                                ),
                                Slider(
                                    value: controller.fontSize,
                                    min: 0.8,
                                    max: 1.4,
                                    divisions: 6,
                                    activeColor: AppColors.primaryGreen,
                                    onChanged: controller.updateFontSize,
                                ),
                            ],
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                            onTap: controller.resetSettings,
                            child: const Text(
                                'Reset to Default',
                                style: TextStyle(
                                    color: AppColors.primaryGreen,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                        ),
                    ],
                ),
            ),
            const SizedBox(height: 16),
             _SettingsCard(
                title: 'Account & Data',
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                           context.read<AuthController>().logout();
                        },
                        icon: const Icon(Icons.logout, color: Colors.red),
                        label: const Text('Log Out', style: TextStyle(color: Colors.red)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
             ),

        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
    final String title;
    final Widget child;

    const _SettingsCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
             border: Border.all(color: Theme.of(context).dividerColor),
             boxShadow: [
             BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
            )
        ]
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                    ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                child,
            ],
        ),
    );
  }
}
