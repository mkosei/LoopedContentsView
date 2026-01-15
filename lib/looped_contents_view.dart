library looped_contents_view;

import 'package:flutter/material.dart';
import 'dart:async';

class LoopedContentsView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Axis scrollDirection;
  final bool pauseOnTouch;
  final Duration resumeDelay;
  const LoopedContentsView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.autoPlay = false,
    this.pauseOnTouch =true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.scrollDirection = Axis.horizontal,
    this.resumeDelay = const Duration(seconds: 3)
  }) : super(key: key);

  @override
  State<LoopedContentsView> createState() => _LoopedContentsViewState();

}

class _LoopedContentsViewState extends State<LoopedContentsView> {
  late final PageController _controller;
  Timer? _autoPlayTimer;
  Timer? _resumeTimer;
  bool _isUserInteracting = false;

  static const int _loopMultiplier = 1000;

  int get _vertialItemCount => widget.itemCount * _loopMultiplier;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _vertialItemCount ~/2);

    if(widget.autoPlay) {
      _startAutoPlay();
    }
  }

  void _startAutoPlay() {
    if (!widget.autoPlay || _autoPlayTimer != null || _isUserInteracting) return;

    _autoPlayTimer = Timer.periodic(widget.autoPlayInterval, (_) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  @override
  void dispose() {
    _controller.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  int _mapIndex(int index) => index % widget.itemCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: widget.pauseOnTouch
          ? (_) {
              _isUserInteracting = true;
              _stopAutoPlay();

              // もし再開タイマーがあればキャンセル
              _resumeTimer?.cancel();
            }
          : null,
      onPanEnd: widget.pauseOnTouch
          ? (_) {
              _isUserInteracting = false;

              _resumeTimer = Timer(widget.resumeDelay, () {
                if (!_isUserInteracting) {
                  _startAutoPlay();
                }
              });
            }
          : null,
        child: PageView.builder(
          controller: _controller,
          scrollDirection: widget.scrollDirection,
          itemCount: _vertialItemCount,
          itemBuilder: (context, index) {
            final actualIndex = _mapIndex(index);
            return widget.itemBuilder(context, actualIndex);
          },
      )
    );
  }
}