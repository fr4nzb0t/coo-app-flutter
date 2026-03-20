import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum AvailabilityBarMode { card, detail }

class AvailabilityBar extends StatefulWidget {
  final double ratio; // availableShares / totalShares
  final AvailabilityBarMode mode;

  const AvailabilityBar({
    super.key,
    required this.ratio,
    this.mode = AvailabilityBarMode.card,
  });

  @override
  State<AvailabilityBar> createState() => _AvailabilityBarState();
}

class _AvailabilityBarState extends State<AvailabilityBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _widthAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _fillColor {
    if (widget.ratio <= 0) return Colors.transparent;
    if (widget.ratio < 0.2) return AppColors.availableAmber;
    return AppColors.availableGreen;
  }

  Color get _trackColor {
    if (widget.mode == AvailabilityBarMode.detail) {
      return AppColors.availableGreenBg;
    }
    return AppColors.takenGrey;
  }

  double get _height => widget.mode == AvailabilityBarMode.detail ? 8.0 : 4.0;

  double get _radius => widget.mode == AvailabilityBarMode.detail ? 4.0 : 2.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        return Container(
          height: _height,
          decoration: BoxDecoration(
            color: _trackColor,
            borderRadius: BorderRadius.circular(_radius),
          ),
          child: AnimatedBuilder(
            animation: _widthAnimation,
            builder: (context, _) {
              final fillWidth = maxWidth * widget.ratio * _widthAnimation.value;
              if (fillWidth <= 0) return const SizedBox.shrink();
              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: fillWidth,
                  height: _height,
                  decoration: BoxDecoration(
                    color: _fillColor,
                    borderRadius: BorderRadius.circular(_radius),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
