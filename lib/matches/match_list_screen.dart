import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/match_list_item.dart';
import '../widgets/ripple_list_item.dart';
import '../constants/constants.dart';
import 'models/matches.dart';

class MatchListScreen extends StatefulWidget {
  const MatchListScreen({Key? key}) : super(key: key);

  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  bool _firstInit = true;
  final _searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_firstInit) {
      _searchController.addListener(() {
        setState(() {});
      });
      _firstInit = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matches =
        context.watch<Matches>().getMatchesWithQuery(_searchController.text);
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: Theme.of(context).canvasColor,
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Search...',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.only(
                left: Dimensions.paddingTwo,
                right: Dimensions.paddingTwo,
                top: Dimensions.paddingOne,
                bottom: Dimensions.matchesListPaddingBottom,
              ),
              itemCount: matches.isEmpty ? 1 : matches.length + 1,
              itemBuilder: (_, index) {
                if (index == 0) {
                  // return const FilterWidget();
                  return const SizedBox.shrink();
                }
                index--;

                return ChangeNotifierProvider.value(
                    value: matches[index],
                    builder: (_, __) {
                      return const RippleListItem(child: MatchListItem());
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
