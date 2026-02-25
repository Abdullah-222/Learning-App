import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_learning_app/controllers/auth_controller.dart';
import 'package:secure_learning_app/constants.dart';

import 'home_screen.dart';
import 'learn_screen.dart';
import 'settings_screen.dart';
import 'placeholder_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
     // We will pass the callback to HomeScreen later, for now just placeholder
     const SizedBox(), 
     const LearnScreen(),
     const SettingsScreen(),
     const PlaceholderScreen(title: 'Community'),
     const PlaceholderScreen(title: 'Events'),
  ];

  @override
  void initState() {
    super.initState();
    _screens[0] = HomeScreen(onGoToLearn: _goToLearnTab);
  }


  void _goToLearnTab() {
    setState(() {
      _currentIndex = 1;
    });
  }

  void _onDestinationSelected(int index) {
      setState(() {
        _currentIndex = index;
      });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final String? userName = context.watch<AuthController>().userName;
    final String initials = _getInitials(userName);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            // Desktop Layout
            return Row(
              children: [
                _DesktopSidebar(
                  currentIndex: _currentIndex,
                  onDestinationSelected: _onDestinationSelected,
                ),
                Expanded(
                  child: Column(
                    children: [
                         // Header
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            color: colorScheme.surface,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Text(
                                        _getPageTitle(_currentIndex),
                                        style: textTheme.titleLarge,
                                    ),
                                    CircleAvatar(
                                        backgroundColor: const Color(0xFFD7F5E8),
                                        child: Text(initials, style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
                                    ),
                                ],
                            ),
                        ),
                        Expanded(
                            child: IndexedStack(
                                index: _currentIndex,
                                children: _screens,
                            ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            // Mobile Layout
            return Scaffold(
                appBar: AppBar(
                    title: Text(_getPageTitle(_currentIndex), style: const TextStyle(fontWeight: FontWeight.bold)),
                    backgroundColor: colorScheme.surface,
                    actions: [
                         Padding(
                           padding: const EdgeInsets.only(right: 16.0),
                           child: CircleAvatar(
                                backgroundColor: const Color(0xFFD7F5E8),
                                child: Text(initials, style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
                            ),
                         ),
                    ],
                ),
                body: IndexedStack(
                    index: _currentIndex,
                    children: _screens,
                ),
                bottomNavigationBar: NavigationBar(
                    selectedIndex: _currentIndex,
                    onDestinationSelected: _onDestinationSelected,
                    backgroundColor: colorScheme.surface,
                    indicatorColor: AppColors.primaryGreen.withValues(alpha: 0.2), // Slight transparency for indicator
                    destinations: const [
                    NavigationDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home, color: AppColors.primaryGreen),
                        label: 'Home',
                    ),
                    NavigationDestination(
                        icon: Icon(Icons.school_outlined),
                        selectedIcon: Icon(Icons.school, color: AppColors.primaryGreen),
                        label: 'Learn',
                    ),
                    NavigationDestination(
                        icon: Icon(Icons.settings_outlined),
                        selectedIcon: Icon(Icons.settings, color: AppColors.primaryGreen),
                        label: 'Settings',
                    ),
                    NavigationDestination(
                        icon: Icon(Icons.people_outline),
                        selectedIcon: Icon(Icons.people, color: AppColors.primaryGreen),
                        label: 'Community',
                    ),
                    NavigationDestination(
                        icon: Icon(Icons.event_note_outlined),
                        selectedIcon: Icon(Icons.event_note, color: AppColors.primaryGreen),
                        label: 'Events',
                    ),
                    ],
                    // Only showing top 3 for mobile bottom bar availability, or we could add more
                ),
            );
          }
        },
      ),
    );
  }

  String _getPageTitle(int index) {
      switch (index) {
          case 0: return 'Home';
          case 1: return 'Learn';
          case 2: return 'Settings';
          case 3: return 'Community';
          case 4: return 'Events';
          default: return 'Secure App';
      }
  }

  String _getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0].substring(0, 1).toUpperCase();
  }
}

class _DesktopSidebar extends StatelessWidget {
  const _DesktopSidebar({
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 250,
      color: colorScheme.surface,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mac-like traffic lights (visual only)
          Row(
            children: [
              _circle(Colors.red),
              const SizedBox(width: 8),
              _circle(Colors.amber),
              const SizedBox(width: 8),
              _circle(Colors.green),
            ],
          ),
          const SizedBox(height: 32),
          
          _SidebarSectionTitle('MAIN'),
          _SidebarItem(
            icon: Icons.home_outlined,
            label: 'Home',
            isSelected: currentIndex == 0,
            onTap: () => onDestinationSelected(0),
            isPrimary: true, // Special styling for Home
          ),
          
          const SizedBox(height: 24),
          _SidebarSectionTitle('TOOLS'),
          _SidebarItem(
            icon: Icons.search,
            label: 'Search', // The loop icon in specific
            isSelected: false, 
            onTap: () {}, 
          ),
           _SidebarItem(
            icon: Icons.check_box_outline_blank, 
            label: 'Playground', // box icon
            isSelected: currentIndex == 1, // Mapping to Learn as a placeholder
            onTap: () => onDestinationSelected(1),
          ),


          const SizedBox(height: 24),
          _SidebarSectionTitle('RESOURCES'),
          _SidebarItem(
            icon: Icons.menu_book_outlined,
            label: 'Learn',
            isSelected: currentIndex == 1,
            onTap: () => onDestinationSelected(1),
          ),

          const SizedBox(height: 24),
          _SidebarSectionTitle('SETTINGS'),
          _SidebarItem(
            icon: Icons.settings_outlined,
            label: 'Preferences',
            isSelected: currentIndex == 2,
            onTap: () => onDestinationSelected(2),
          ),
        ],
      ),
    );
  }

  Widget _circle(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _SidebarSectionTitle extends StatelessWidget {
  final String title;
  const _SidebarSectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isPrimary;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isPrimary 
        ? AppColors.primaryGreen 
        : (isSelected ? (isDark ? Colors.white.withValues(alpha: 0.1) : const Color(0xFFE8F0FE)) : Colors.transparent);
    
    final iconColor = isPrimary
        ? Colors.white
        : (isSelected ? AppColors.primaryGreen : colorScheme.onSurfaceVariant);

    final textColor = isPrimary
        ? Colors.white
        : (isSelected ? colorScheme.onSurface : colorScheme.onSurface);

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 20),
        title: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: isSelected || isPrimary ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        onTap: onTap,
        dense: true,
        horizontalTitleGap: 0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
