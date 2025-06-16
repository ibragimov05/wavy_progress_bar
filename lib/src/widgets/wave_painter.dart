import 'dart:math';

import 'package:flutter/material.dart';

const foregroundWaveColor = Color(0xFF00aaff);
const backgroundWaveColor = Color(0xFF0073E6);

/// {@template wave_painter}
/// WavePainter for SphericalWaterRippleProgressBar widget.
/// {@endtemplate}
class WavePainter extends CustomPainter {
  /// {@macro wave_painter}
  WavePainter({required this.progress, required this.waveAnimation, required this.circleRadius})
    : super(repaint: Listenable.merge([progress, waveAnimation]));
  final Animation<double> progress;
  final Animation<double> waveAnimation;
  final double circleRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);
    _drawWaves(canvas);
  }

  /// Draws the wave fill inside the clipped circle area.
  void _drawWaves(Canvas canvas) {
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: Offset.zero, radius: circleRadius)));

    _drawSineWave(canvas, backgroundWaveColor);
    _drawSineWave(canvas, foregroundWaveColor, mirror: true, shift: circleRadius / 2);
  }

  void _drawSineWave(Canvas canvas, Color waveColor, {double shift = 0.0, bool mirror = false}) {
    if (mirror) {
      canvas
        ..save()
        ..transform(Matrix4.rotationY(pi).storage);
    }

    var startX = -circleRadius;
    var endX = circleRadius;
    var startY = circleRadius;
    var endY = -circleRadius;

    var amplitude = circleRadius * 0.15;
    var angularVelocity = pi / circleRadius;
    var delta = Curves.slowMiddle.transform(progress.value / 100);

    var offsetX = 2 * circleRadius * waveAnimation.value + shift;
    var offsetY = startY + (endY - startY - amplitude) * delta;

    var wavePaint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..isAntiAlias = true;

    var path = Path();

    for (var x = startX; x <= endX; x++) {
      var y = amplitude * sin(angularVelocity * (x + offsetX));
      if (x == startX) {
        path.moveTo(x, y + offsetY);
      } else {
        path.lineTo(x, y + offsetY);
      }
    }

    path
      ..lineTo(endX, startY)
      ..lineTo(startX, startY)
      ..close();

    canvas.drawPath(path, wavePaint);
    if (mirror) canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
