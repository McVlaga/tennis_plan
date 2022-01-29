import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  _FiltersWidgetState createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FilterWidget> {
  void _showFilteringPopupMenu() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(300, 120, 300, 120),
      items: [
        const PopupMenuItem<String>(child: Text('Wins'), value: 'Wins'),
        const PopupMenuItem<String>(child: Text('Losses'), value: 'Loss'),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:
          const BorderRadius.all(Radius.circular(Dimensions.borderRadius)),
      onTap: _showFilteringPopupMenu,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingOne),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Icon(Icons.filter_list),
            Text(
              'Filter',
              style: TextStyle(
                fontSize: Fonts.matchListItemFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
