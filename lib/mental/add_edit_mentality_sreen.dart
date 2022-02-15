import 'package:flutter/material.dart';

class AddEditMentalityScreen extends StatelessWidget {
  const AddEditMentalityScreen({Key? key}) : super(key: key);
  static const routeName = '/add-edit-mentality';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentality'),
        backgroundColor: Colors.green,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
