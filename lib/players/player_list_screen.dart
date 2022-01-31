import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'widgets/player_list_item.dart';

class PlayerListScreen extends StatelessWidget {
  static const routeName = '/player-list';

  const PlayerListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Players'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(
            left: Dimensions.paddingOne,
            right: Dimensions.paddingOne,
            top: Dimensions.paddingOne,
            bottom: Dimensions.matchesListPaddingBottom),
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return const PlayerListItem();
        },
      ),
    );
  }
}
