import 'package:flutter/material.dart';

class AddEditOtherGoalsScreen extends StatelessWidget {
  const AddEditOtherGoalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other Goals'),
        backgroundColor: Colors.orange,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
