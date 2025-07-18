import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:construction_manager_app/theme/theme_provider.dart';

class ThemeSettingsScreen extends StatefulWidget {
  final double screenWidth;

  const ThemeSettingsScreen({super.key, required this.screenWidth});

  @override
  State<ThemeSettingsScreen> createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  String _selectedTheme = 'System Default'; // Default to system theme
  final List<String> _themeOptions = ['System Default', 'Light', 'Dark'];

  @override
  void initState() {
    super.initState();
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _selectedTheme = themeProvider.isDarkMode ? 'Dark' : 'Light';
  }

  void _selectTheme(String theme) {
    setState(() {
      _selectedTheme = theme;
    });
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    if (theme == 'Dark') {
      themeProvider.toggleTheme(true);
    } else if (theme == 'Light') {
      themeProvider.toggleTheme(false);
    }
    // No action for 'System Default' to respect system settings
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: theme.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: isDarkMode ? const Color(0xFF1C2526) : const Color(0xFFF5F7FA),
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: widget.screenWidth * 0.05,
            vertical: widget.screenWidth * 0.04,
          ),
          children: [
            const Text(
              'Appearance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF007AFF),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: theme.cardColor,
              child: Column(
                children:
                    _themeOptions.map((themeOption) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        title: Text(
                          themeOption,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                _selectedTheme == themeOption
                                    ? theme.primaryColor
                                    : theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                        trailing:
                            _selectedTheme == themeOption
                                ? const Icon(
                                  Icons.check,
                                  color: Color(0xFF007AFF),
                                )
                                : null,
                        onTap: () => _selectTheme(themeOption),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
