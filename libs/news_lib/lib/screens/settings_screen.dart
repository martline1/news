import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_lib/blocs/news/news_bloc.dart';
import 'package:news_lib/blocs/news/news_events.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<NewsBloc>().add(GetFavoritesFromDB());

    final apiKey = context.read<NewsBloc>().state.apiKey;

    controller.text = apiKey;

    controller.addListener(() {
      context.read<NewsBloc>().add(SetApiKey(controller.text));
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Api Key:',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.amber[800]!,
                      ),
                    ),
                    hintText: 'Enter your newsorg api key',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
