import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'Config/palette.dart';

class SignInPainter extends CustomPainter {
  Animation<double> animation;
  SignInPainter({required this.animation})
      : bluePaint = Paint()
          ..color = Palette.lightBlue
          ..style = PaintingStyle.fill,
        greyPaint = Paint()
          ..color = Palette.darkBlue
          ..style = PaintingStyle.fill,
        orangePaint = Paint()
          ..color = Palette.orange
          ..style = PaintingStyle.fill,
        greyAnim = CurvedAnimation(
          parent: animation,
          curve: SpringCurve(),
          reverseCurve: Curves.easeInCirc,
        ),
        super(repaint: animation);
  final bluePaint;
  final Animation<double> greyAnim;
  final orangePaint;
  final greyPaint;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    paintBlue(canvas, size);
    paintDarkBlue(canvas, size);
  }

  paintDarkBlue(Canvas canvas, Size size) {
    Animation<double> animation = greyAnim;
    Path path = Path();
    path.moveTo(0, size.height * (1 / 4));
    path.lineTo(size.width, size.height * (1 / 4));
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height * (1 / 4));
    path.quadraticBezierTo(
        lerpDouble(0, size.width * 0.05, animation.value)!,
        lerpDouble(size.height * (1 / 4), size.height * 0.50, animation.value)!,
        lerpDouble(0, size.width / 2, animation.value)!,
        lerpDouble(
            size.height * (1 / 4), size.height * (1 / 4), animation.value)!);
    /*path.quadraticBezierTo(size.width * 0.05, size.height * 0.50,
        size.width / 2, size.height * (1 / 4));*/
    path.quadraticBezierTo(
        lerpDouble(size.width / 2, size.width * 0.70, animation.value)!,
        lerpDouble(
            size.height * (1 / 4), size.height * 0.125, animation.value)!,
        lerpDouble(size.width / 2, size.width, animation.value)!,
        lerpDouble(
            size.height * (1 / 2), size.height * (1 / 4), animation.value)!);
    /*path.quadraticBezierTo(size.width * 0.70, size.height * 0.125, size.width,
        size.height * (1 / 4));*/
    canvas.drawPath(path, greyPaint);
  }

  paintBlue(Canvas canvas, Size size) {
    Animation<double> animation = greyAnim;
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        lerpDouble(0, size.width * 0.05, animation.value)!,
        lerpDouble(size.height, size.height * 0.80, animation.value)!,
        lerpDouble(0, size.width / 2, animation.value)!,
        lerpDouble(size.height, size.height * .9, animation.value)!);
    /*path.quadraticBezierTo(size.width * 0.05, size.height * 0.80,
        size.width / 2, size.height * 0.90);*/
    path.quadraticBezierTo(
        lerpDouble(0, size.width * 0.7, animation.value)!,
        lerpDouble(size.height * 0.80, size.height * .95, animation.value)!,
        lerpDouble(0, size.width, animation.value)!,
        lerpDouble(size.height * .9, size.height * .8, animation.value)!);
    /*path.quadraticBezierTo(
        size.width * 0.70, size.height * 0.95, size.width, size.height * 0.8);*/
    canvas.drawPath(path, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}
