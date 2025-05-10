import 'package:flutter/material.dart';



class CustomProgressBarDemo extends StatefulWidget {
  const CustomProgressBarDemo({super.key});

  @override
  State<CustomProgressBarDemo> createState() => _CustomProgressBarDemoState();
}

class _CustomProgressBarDemoState extends State<CustomProgressBarDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double _progress = 0.0; // initial progress value

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: _progress, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _progress = _animation.value;
        });
      });
  }

  void _startAnimation() {
    _animation = Tween<double>(begin: _progress, end: 1.0).animate(_controller);
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color getBarColor(double progress) {
    if (progress < 0.5) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Progress Bar")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: LinearProgressBarPainter(_progress, getBarColor(_progress)),
              child: const SizedBox(width: 300, height: 20),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _startAnimation,
              child: const Text("Animate to 100%"),
            ),
          ],
        ),
      ),
    );
  }
}

class LinearProgressBarPainter extends CustomPainter {
  final double progress;
  final Color color;

  LinearProgressBarPainter(this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Draw progress
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width * progress, size.height), progressPaint);
  }

  @override
  bool shouldRepaint(covariant LinearProgressBarPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
