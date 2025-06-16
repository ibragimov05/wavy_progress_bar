import 'package:flutter/material.dart';

import 'main_screen.dart';

/// {@template main_controller}
/// MainController for CircularWaveProgress widget.
/// {@endtemplate}
abstract class MainController extends State<CircularWaveProgress> with TickerProviderStateMixin {
  late final Animation<double> progressAnimation;
  late final AnimationController progressController;
  late final AnimationController waveController;

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    waveController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    progressAnimation = Tween<double>(begin: 0, end: 100).animate(progressController);
    progressController.addListener(_progressListener);
    waveController.repeat();
  }

  void _progressListener() {
    if (progressController.isCompleted) setState(() {});
  }

  @override
  void dispose() {
    progressController.dispose();
    waveController.dispose();
    super.dispose();
  }

  void _runAnimation() {
    progressController.forward();
    setState(() {});
  }

  void _refreshAnimation() {
    progressController.reset();
    setState(() {});
  }

  void _stopAnimation() {
    progressController.stop();
    setState(() {});
  }

  IconData get icon {
    if (progressController.isAnimating) return Icons.stop_rounded;
    if (progressController.isCompleted) return Icons.refresh_rounded;
    return Icons.play_arrow_rounded;
  }

  VoidCallback get callback {
    if (progressController.isAnimating) return _stopAnimation;
    if (progressController.isCompleted) return _refreshAnimation;
    return _runAnimation;
  }

  Color get buttonColor {
    if (progressController.isAnimating) return const Color(0xFFF44336);
    if (progressController.isCompleted) return const Color(0xFF2196F3);
    return const Color(0xFF4CAF50);
  }
}
