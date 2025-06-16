import 'package:flutter/material.dart';

import 'main_controller.dart';
import 'widgets/progress_painter.dart';
import 'widgets/wave_painter.dart';

/// {@template circular_wave_progress}
/// CircularWaveProgress widget.
/// {@endtemplate}
class CircularWaveProgress extends StatefulWidget {
  /// {@macro circular_wave_progress}
  const CircularWaveProgress({super.key});

  @override
  State<StatefulWidget> createState() => _CircularWaveProgressState();
}

class _CircularWaveProgressState extends MainController {
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(30),
    child: Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (_, constraints) => Center(
              child: SphericalWaterRippleProgressBar(
                progress: progressAnimation,
                waveAnimation: waveController,
                sphereRadius: constraints.biggest.shortestSide / 2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        IconButton(
          iconSize: 77,
          onPressed: callback,
          icon: Icon(icon, color: buttonColor),
        ),
      ],
    ),
  );
}

/// {@template spherical_water_ripple_progress_bar}
/// SphericalWaterRippleProgressBar widget.
/// {@endtemplate}
class SphericalWaterRippleProgressBar extends StatelessWidget {
  /// {@macro spherical_water_ripple_progress_bar}
  const SphericalWaterRippleProgressBar({
    required Animation<double> progress,
    required Animation<double> waveAnimation,
    required this.sphereRadius,
    super.key,
  }) : _progress = progress,
       _waveAnimation = waveAnimation;

  final Animation<double> _progress;
  final Animation<double> _waveAnimation;
  final double sphereRadius;

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: WavePainter(progress: _progress, waveAnimation: _waveAnimation, circleRadius: sphereRadius),
    foregroundPainter: ProgressPainter(progress: _progress, circleRadius: sphereRadius),
  );
}
