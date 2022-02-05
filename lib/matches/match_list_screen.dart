import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/matches/models/a_match.dart';
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
  var matches = <AMatch>[];
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
    matches =
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
                  color: Theme.of(context).colorScheme.surface,
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
                top: Dimensions.paddingTwo,
                bottom: Dimensions.matchesListPaddingBottom,
              ),
              itemCount: matches.isEmpty ? 1 : matches.length + 1,
              itemBuilder: (_, index) {
                if (index == 0) {
                  // return const FilterWidget();
                  return SizedBox.shrink();
                }
                index--;

                return RippleListItem(
                  child: MatchListItem(
                    match: matches[index],
                  ),
                );
              },
            ),
          ),
          // Container(
          //   height: 100,
          //   width: double.infinity,
          //   color: Theme.of(context).appBarTheme.backgroundColor,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextField(
          //           decoration: InputDecoration(
          //             prefixIcon: Icon(Icons.search),
          //             isDense: true,
          //             filled: true,
          //             fillColor: Colors.transparent,
          //             border: InputBorder.none,
          //             focusedBorder: InputBorder.none,
          //             hintText: 'Search...',
          //           ),
          //         ),
          //       ),
          //       const SizedBox(width: 8),
          //       ClipRRect(
          //         borderRadius: const BorderRadius.all(
          //           Radius.circular(Dimensions.borderRadius),
          //         ),
          //         child: Material(
          //           color: Colors.transparent,
          //           child: InkWell(
          //             onTap: () {},
          //             child: SizedBox(
          //               height: double.infinity,
          //               width: 70,
          //               child: Icon(
          //                 Icons.filter_list,
          //                 color: Theme.of(context).colorScheme.onBackground,
          //                 size: 30,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
