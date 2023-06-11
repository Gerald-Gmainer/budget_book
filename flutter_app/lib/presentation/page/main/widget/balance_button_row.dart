import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class BalanceButtonRow extends StatelessWidget {
  static const double size = 100;

  _navigateToCrud(BuildContext context, CategoryType categoryType) {
    final BookingCrudModel model = BookingCrudModel(
      model: BookingModel.empty(),
      categoryType: categoryType,
    );
    Navigator.of(context).pushNamed(BookingCrudPage.route, arguments: model);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            _navigateToCrud(context, CategoryType.outcome);
          },
          iconSize: size,
          icon: CustomPaint(
            size: const Size(size, size),
            painter: _CustomRemoveIconPainter(color: AppColors.outcomeColor),
          ),
        ),
        IconButton(
          onPressed: () {
            _navigateToCrud(context, CategoryType.income);
          },
          iconSize: size,
          icon: CustomPaint(
            size: const Size(size, size),
            painter: _CustomPlusIconPainter(color: AppColors.incomeColor),
          ),
        ),
      ],
    );
  }
}

class _CustomRemoveIconPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _CustomRemoveIconPainter({required this.color, this.strokeWidth = 4});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width / 2 - strokeWidth;

    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    final double lineOffset = strokeWidth / 2;
    const double lineGap = 30;

    canvas.drawLine(
      Offset(lineOffset + lineGap, centerY),
      Offset(size.width - lineOffset - lineGap, centerY),
      paint,
    );
  }

  @override
  bool shouldRepaint(_CustomRemoveIconPainter oldDelegate) => false;
}

class _CustomPlusIconPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _CustomPlusIconPainter({required this.color, this.strokeWidth = 4});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width / 2 - strokeWidth;

    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    final double lineLength = size.width - strokeWidth * 2;
    const double lineGap = 30;

    canvas.drawLine(
      Offset(centerX, centerY - lineLength / 2 + lineGap),
      Offset(centerX, centerY + lineLength / 2 - lineGap),
      paint,
    );

    canvas.drawLine(
      Offset(centerX - lineLength / 2 + lineGap, centerY),
      Offset(centerX + lineLength / 2 - lineGap, centerY),
      paint,
    );
  }

  @override
  bool shouldRepaint(_CustomPlusIconPainter oldDelegate) => false;
}
