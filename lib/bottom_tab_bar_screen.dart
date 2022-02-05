import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'add_edit_match/add_edit_match_screen.dart';
import 'constants/constants.dart';
import 'settings/settings_screen.dart';

import 'matches/match_list_screen.dart';
import 'players/player_list_screen.dart';

class BottomTabBarScreen extends StatefulWidget {
  const BottomTabBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomTabBarScreen> createState() => _BottomTabBarScreenState();
}

class _BottomTabBarScreenState extends State<BottomTabBarScreen> {
  int _page = 0;
  String _appBarTitle = 'MyMatches';
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    if (Platform.isAndroid) {
      setOptimalDisplayMode();
    }
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _page = index;
      switch (index) {
        case 0:
          _appBarTitle = 'My Matches';
          break;
        case 1:
          _appBarTitle = 'Players';
          break;
        case 2:
          _appBarTitle = 'Settings';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: IndexedStack(
        index: _page,
        children: const [
          MatchListScreen(),
          PlayerListScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: _bottomNavigationKey,
        currentIndex: _page,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 4,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
            ),
            activeIcon: Icon(
              Icons.home,
              size: 30,
            ),
            label: '',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              size: 30,
            ),
            activeIcon: Icon(
              Icons.person,
              size: 30,
            ),
            label: '',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
              size: 30,
            ),
            activeIcon: Icon(
              Icons.settings,
              size: 30,
            ),
            label: '',
            tooltip: '',
          ),
        ],
        onTap: onTabTapped,
      ),
      floatingActionButton: _page == 2
          ? null
          : FloatingActionButton(
              child: Icon(
                Icons.add,
                size: Dimensions.navBarItemIconHeight,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                if (_page == 0) {
                  Navigator.pushNamed(context, AddEditMatchScreen.routeName);
                }
              },
            ),
    );
  }

  Future<void> setOptimalDisplayMode() async {
    final List<DisplayMode> supported = await FlutterDisplayMode.supported;
    final DisplayMode active = await FlutterDisplayMode.active;

    final List<DisplayMode> sameResolution = supported
        .where((DisplayMode m) =>
            m.width == active.width && m.height == active.height)
        .toList()
      ..sort((DisplayMode a, DisplayMode b) =>
          b.refreshRate.compareTo(a.refreshRate));

    final DisplayMode mostOptimalMode =
        sameResolution.isNotEmpty ? sameResolution.first : active;

    /// This setting is per session.
    /// Please ensure this was placed with `initState` of your root widget.
    await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
  }
}
