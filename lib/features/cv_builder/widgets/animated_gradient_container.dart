// lib/features/cv_builder/widgets/animated_gradient_container.dart
import 'package:flutter/material.dart';

class AnimatedGradientContainer extends StatefulWidget {
  final Widget child;
  final List<Color> gradientColors;
  final Duration duration;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const AnimatedGradientContainer({
    super.key,
    required this.child,
    required this.gradientColors,
    this.duration = const Duration(seconds: 3),
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

  @override
  State<AnimatedGradientContainer> createState() =>
      _AnimatedGradientContainerState();
}

class _AnimatedGradientContainerState extends State<AnimatedGradientContainer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late List<Color> _currentColors;
  late List<Color> _targetColors;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _currentColors = List.from(widget.gradientColors);
    _targetColors = List.from(widget.gradientColors);

    _startAnimation();
  }

  void _startAnimation() {
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Shuffle colors for next animation
        _targetColors = List.from(widget.gradientColors)..shuffle();
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _currentColors = List.from(_targetColors);
        });
        _targetColors = List.from(widget.gradientColors)..shuffle();
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: widget.begin,
              end: widget.end,
              colors: _currentColors.asMap().entries.map((entry) {
                final index = entry.key;
                final currentColor = entry.value;
                final targetColor = _targetColors.length > index
                    ? _targetColors[index]
                    : currentColor;

                return Color.lerp(currentColor, targetColor, _animation.value)!;
              }).toList(),
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
