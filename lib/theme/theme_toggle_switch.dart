import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return DropdownButton<String>(
      value: themeProvider.isDarkMode ? 'Dark' : 'Light',
      onChanged: (String? newValue) {
        if (newValue != null) {
          themeProvider.toggleTheme(newValue == 'Dark');
          // Force a rebuild to reflect the theme change immediately
          (context as Element).markNeedsBuild();
        }
      },
      items:
          <String>['Light', 'Dark'].map<DropdownMenuItem<String>>((
            String value,
          ) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
      icon: const Icon(Icons.arrow_drop_down),
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      dropdownColor: Theme.of(context).cardColor,
      underline: const SizedBox(),
    );
  }
}
