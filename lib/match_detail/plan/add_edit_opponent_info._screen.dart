import 'package:flutter/material.dart';

class AddEditOpponentInfoScreen extends StatelessWidget {
  const AddEditOpponentInfoScreen({Key? key}) : super(key: key);
  static const routeName = '/add-edit-opponent-info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opponent Info'),
        backgroundColor: Colors.red,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
