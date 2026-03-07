import 'package:flutter/material.dart';
import 'package:heylo/features/auth/pages/welcome_page.dart';
import 'package:heylo/theme/heylo_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heylo',
      theme: HeyloTheme.darkTheme,
      home: const WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

