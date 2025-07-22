import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final VoidCallback onBackClick;

  const DetailsScreen({super.key, required this.onBackClick});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: onBackClick,
          child: const Text('Go back to the Home screen'),
        ),
      ),
    );
  }
}