import 'package:flutter/material.dart';

class AddEditTacticalGoalsScreen extends StatelessWidget {
  const AddEditTacticalGoalsScreen({Key? key}) : super(key: key);
  static const routeName = '/add-edit-tactical-goals';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tactical Goals'),
        backgroundColor: Colors.blue,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
