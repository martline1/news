import 'package:flutter/material.dart';

class NewsDetailsScreen extends StatelessWidget {
  final String id;

  const NewsDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('NewsDetailsScreen'),
      ),
    );
  }
}
