// ---------------------------------------------------------------
// 1. Add this helper widget anywhere in the file (or in a separate file)
// ---------------------------------------------------------------
import 'package:flutter/cupertino.dart';

class AnimatedTextReveal extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration totalDuration; // total animation time
  final Duration letterDelay; // pause between letters

  const AnimatedTextReveal({
    required this.text,
    required this.style,
    this.totalDuration = const Duration(milliseconds: 1200),
    this.letterDelay = const Duration(milliseconds: 80),
    super.key,
  });

  @override
  State<AnimatedTextReveal> createState() => _AnimatedTextRevealState();
}

class _AnimatedTextRevealState extends State<AnimatedTextReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _letterAnims;

  @override
  void initState() {
    super.initState();

    final int letters = widget.text.length;
    final double perLetter = 1.0 / letters;

    _controller = AnimationController(
      vsync: this,
      duration: widget.totalDuration,
    )..forward();

    // Build a TweenSequence that starts each letter a bit later
    final List<TweenSequenceItem<double>> items = [];
    for (int i = 0; i < letters; i++) {
      final double start = i * perLetter;
      final double end = (i + 1) * perLetter;
      items.add(
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          weight: end - start,
        ),
      );
    }

    final sequence = TweenSequence<double>(items);

    _letterAnims = List.generate(
      letters,
      (i) => sequence.animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(i * perLetter, 1.0, curve: Curves.easeOutCubic),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: widget.text.split('').asMap().entries.map((entry) {
            final int idx = entry.key;
            final String char = entry.value;
            final double progress = _letterAnims[idx].value;

            // slide in from left + fade
            return Transform.translate(
              offset: Offset(50 * (1 - progress), 0),
              child: Opacity(
                opacity: progress,
                child: Text(char, style: widget.style),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
