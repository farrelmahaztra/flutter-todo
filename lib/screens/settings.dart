import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool _darkModeEnabled = false;

  Widget _body() {
    return SwitchListTile(
      title: const Text('Turn on dark mode'),
      value: _darkModeEnabled,
      onChanged: (bool value) {
        setState(() {
          _darkModeEnabled = value;
        });
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
