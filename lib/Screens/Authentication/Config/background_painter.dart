import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:trybae_ticket_system/Screens/Authentication/Config/palette.dart';

class BackgroundPainter extends CustomPainter {
  Animation<double> animation;
  BackgroundPainter({required this.animation})
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
          curve: Curves.easeInOutBack,
          reverseCurve: Curves.easeInCirc,
        ),
        blueAnim = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutBack,
          reverseCurve: Curves.easeInCirc,
        ),
        super(repaint: animation);
  final bluePaint;
  final Animation<double> greyAnim;
  final Animation<double> blueAnim;
  final orangePaint;
  final greyPaint;
  @override
  void paint(Canvas canvas, Size size) {
    print('Painting');
    paintBlue(canvas, size);
    paintDarkBlue(canvas, size);
  }

  prnt(String str, double d) {
    print('$str: $d');
  }

  paintDarkBlue(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, 150);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, 250);
    path.quadraticBezierTo(
        lerpDouble(0, size.width / 4, greyAnim.value)!,
        lerpDouble(250, size.height / 2, greyAnim.value)!,
        lerpDouble(size.width / 4, size.width * (3 / 4), greyAnim.value)!,
        lerpDouble(size.height / 2, 150, greyAnim.value)!);
    path.quadraticBezierTo(
        lerpDouble(
            size.width * (3 / 4), (size.width) * (0.86), greyAnim.value)!,
        lerpDouble(150, 100, greyAnim.value)!,
        lerpDouble(size.width * (3 / 4), (size.width), greyAnim.value)!,
        lerpDouble(100, 150, greyAnim.value)!);
    canvas.drawPath(path, greyPaint);
  }

  paintBlue(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    //path.lineTo(0, size.height / 2);
    //path.moveTo(0, size.height / 2);
    //path.lineTo(size.width, size.height / 2);
    //path.lineTo(size.width, 0);
    //path.lineTo(0, 0);
    //lerpDouble(a, b, t)
    prnt('x-coordinate', lerpDouble(size.width / 2, 0, blueAnim.value)!);
    prnt('y-coordinate', lerpDouble(size.width / 2, 0, blueAnim.value)!);
    _addPointsToPath(path, [
      Point(0, 0),
      Point(lerpDouble(0, size.width / 2, blueAnim.value)!,
          lerpDouble(0, size.height / 2, blueAnim.value)!),
      Point(size.width, size.height / 2)
    ]);

    canvas.drawPath(path, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('Need three or more points to create a path.');
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) /
          2; //Looks at the current point + the next point on the line divided by two
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }

    // connect the last two points
    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

/*class SpringCurve extends Curve {
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
}*/
