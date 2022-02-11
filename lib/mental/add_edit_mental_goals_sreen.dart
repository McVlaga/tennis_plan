import 'package:flutter/material.dart';

class AddEditMentalGoalsScreen extends StatelessWidget {
  const AddEditMentalGoalsScreen({Key? key}) : super(key: key);
  static const routeName = '/add-edit-mental-goals';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Goals'),
        backgroundColor: Colors.green,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
