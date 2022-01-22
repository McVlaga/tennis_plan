import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

import '../constants/constants.dart';
import '../matches/match_list_screen.dart';
import '../players/player_list_screen.dart';

class BottomTabBarScreen extends StatefulWidget {
  const BottomTabBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomTabBarScreen> createState() => _BottomTabBarScreenState();
}

class _BottomTabBarScreenState extends State<BottomTabBarScreen> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _screens = [
    const MatchListScreen(),
    const PlayerListScreen(),
    const PlayerListScreen(),
  ];

  @override
  void initState() {
    if (Platform.isAndroid) {
      setOptimalDisplayMode();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_page],
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: Dimensions.navBarHeight,
        animationCurve: Curves.easeInOut,
        animationDuration:
            const Duration(milliseconds: Animations.animationDuration),
        buttonBackgroundColor: AppColors.accentColor,
        color: AppColors.primaryColor,
        backgroundColor: Colors.transparent,
        items: const <Widget>[
          Icon(
            Icons.home,
            color: AppColors.tabBarItemColor,
            size: Dimensions.navBarItemIconHeight,
          ),
          Icon(
            Icons.person,
            color: AppColors.tabBarItemColor,
            size: Dimensions.navBarItemIconHeight,
          ),
          Icon(
            Icons.settings,
            color: AppColors.tabBarItemColor,
            size: Dimensions.navBarItemIconHeight,
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
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
