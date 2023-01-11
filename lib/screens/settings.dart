import 'package:flutter/material.dart';
import 'package:todo/main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  Widget _body() {
    bool darkModeEnabled = StateContainer.of(context).darkModeEnabled;

    return SwitchListTile(
      title: const Text('Turn on dark mode'),
      value: darkModeEnabled,
      onChanged: (bool value) {
        StateContainer.of(context).toggleDarkMode();
      },
      secondary: const Icon(Icons.lightbulb_outline),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: _body());
  }
}
