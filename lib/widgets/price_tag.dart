import 'package:flutter/material.dart';

class TagPainter extends CustomPainter {
  final String text;
  final double price;

  TagPainter({required this.text, required this.price});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final textSpan = TextSpan(
      text: '\$$price',
      style: const TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);

    // Draw the tag shape
    Path path = Path();
    path.moveTo(size.width, 0); // Start from the top right
    path.lineTo(15, 0); // Draw to the left top edge near the arrow notch
    path.lineTo(0, size.height / 2); // Draw to the center left (notch point)
    path.lineTo(15, size.height); // Draw to the bottom left edge near the notch
    path.lineTo(size.width, size.height); // Draw to the bottom right
    path.close(); // Close the path back to the top right

    canvas.drawPath(path, paint);

    // Draw the hole
    Paint holePaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(15, size.height / 2), 3, holePaint);

    // Position the text
    textPainter.paint(
        canvas,
        Offset(size.width / 2 - textPainter.width / 4,
            size.height / 2 - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class PriceTag extends StatelessWidget {
  final double price;

  const PriceTag({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue, // Background color of the price tag
        borderRadius: BorderRadius.circular(4), // Rounded corners
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Use minimum space that Row can use
        children: <Widget>[
          const Icon(Icons.label,
              color: Colors.white, size: 14), // Price tag icon
          Text(' \$$price',
              style: const TextStyle(
                  color: Colors.white, fontSize: 12)), // Price text
        ],
      ),
    );
  }
}
