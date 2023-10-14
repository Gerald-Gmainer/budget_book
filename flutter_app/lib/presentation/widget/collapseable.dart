import 'dart:math';

import 'package:flutter/material.dart';

class CollapseableList extends StatefulWidget {
  final List<CollapseableItem> items;

  const CollapseableList({required this.items});

  @override
  State<CollapseableList> createState() => _CollapseableListState();
}

class _CollapseableListState extends State<CollapseableList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return Column(
          children: [
            _buildHeader(item),
            _buildBody(item),
          ],
        );
      },
    );
  }

  Widget _buildHeader(CollapseableItem item) {
    return ListTile(
      title: item.header,
      leading: AnimatedRotationIcon(
        isExpanded: item.isExpanded,
        duration: const Duration(milliseconds: 300),
      ),
      trailing: item.trailing,
      minLeadingWidth: 10,
      dense: true,
      onTap: () {
        setState(() {
          item.isExpanded = !item.isExpanded;
        });
      },
    );
  }

  Widget _buildBody(CollapseableItem item) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      firstChild: Container(),
      secondChild: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: SingleChildScrollView(
          child: item.body,
        ),
      ),
      crossFadeState: item.isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}

class AnimatedRotationIcon extends StatefulWidget {
  final bool isExpanded;
  final Duration duration;

  const AnimatedRotationIcon({required this.isExpanded, required this.duration});

  @override
  State<AnimatedRotationIcon> createState() => _AnimatedRotationIconState();
}

class _AnimatedRotationIconState extends State<AnimatedRotationIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _rotationAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant AnimatedRotationIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value * pi,
          child: Icon(
            Icons.expand_less,
          ),
        );
      },
    );
  }
}

class CollapseableItem {
  final Widget header;
  final Widget body;
  final Widget? trailing;
  bool isExpanded;

  CollapseableItem({
    required this.header,
    required this.body,
    this.isExpanded = false,
    this.trailing,
  });
}
