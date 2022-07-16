import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../services/themes/app_theme.dart';

const _labelAngle = pi / 2 * 0.2;

class CardLabel extends StatelessWidget {
  const CardLabel._({
    required this.color,
    required this.label,
    required this.angle,
    required this.alignment,
    Key? key,
  }) : super(key: key);

  factory CardLabel.right() {
    return const CardLabel._(
      color: AppTheme.right,
      label: 'LIKE',
      angle: -_labelAngle,
      alignment: Alignment.topLeft,
    );
  }

  factory CardLabel.left() {
    return const CardLabel._(
      color: AppTheme.left,
      label: 'NOPE',
      angle: _labelAngle,
      alignment: Alignment.topRight,
    );
  }

  factory CardLabel.up() {
    return const CardLabel._(
      color: AppTheme.up,
      label: 'UP',
      angle: _labelAngle,
      alignment: Alignment(0, 0.5),
    );
  }

  factory CardLabel.down() {
    return const CardLabel._(
      color: AppTheme.down,
      label: 'DOWN',
      angle: -_labelAngle,
      alignment: Alignment(0, -0.75),
    );
  }

  final Color color;
  final String label;
  final double angle;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 12,
      ),
      child: Transform.rotate(
        angle: angle,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: color,
              width: 4,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(6),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
              color: color,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class CardOverlay extends StatelessWidget {
  const CardOverlay({
    required this.direction,
    required this.swipeProgress,
    Key? key,
  }) : super(key: key);
  final SwipeDirection direction;
  final double swipeProgress;

  @override
  Widget build(BuildContext context) {
    final opacity = min<double>(swipeProgress, 1);

    final isRight = direction == SwipeDirection.right;
    final isLeft = direction == SwipeDirection.left;
    final isUp = direction == SwipeDirection.up;
    final isDown = direction == SwipeDirection.down;
    return Stack(
      children: [
        Opacity(
          opacity: isRight ? opacity : 0,
          child: CardLabel.right(),
        ),
        Opacity(
          opacity: isLeft ? opacity : 0,
          child: CardLabel.left(),
        ),
        Opacity(
          opacity: isUp ? opacity : 0,
          child: CardLabel.up(),
        ),
        Opacity(
          opacity: isDown ? opacity : 0,
          child: CardLabel.down(),
        ),
      ],
    );
  }
}
