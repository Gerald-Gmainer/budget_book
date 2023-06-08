import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

import 'left_drawer_button.dart';

class LeftDrawer extends StatefulWidget {
  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  final double _menuWidth = 180.0;

  @override
  Widget build(BuildContext context) {
    final menuState = Provider.of<LeftDrawerMenuState>(context);

    return Stack(
      children: [
        IgnorePointer(
          ignoring: !menuState.isMenuOpen,
          child: GestureDetector(
            onTap: () {
              menuState.toggleMenu();
            },
            child: Container(
              color: menuState.isMenuOpen ? Colors.black12 : Colors.transparent,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          top: 0,
          bottom: 0,
          left: menuState.isMenuOpen ? 0 : -_menuWidth,
          curve: Curves.easeInOut,
          child: Container(
            width: _menuWidth,
            color: AppColors.secondaryColor,
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ListTile(
          title: Text('Item 1'),
          onTap: () {
            // Handle item 1 tap
          },
        ),
        ListTile(
          title: Text('Item 2'),
          onTap: () {
            // Handle item 2 tap
          },
        ),
      ],
    );
  }
}
