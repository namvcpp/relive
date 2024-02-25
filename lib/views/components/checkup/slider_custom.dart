import 'package:fit_worker/providers/notifiers/locale.notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderCustomThumb extends StatefulWidget {
  @override
  _SliderCustomThumbState createState() => _SliderCustomThumbState();
}

class _SliderCustomThumbState extends State<SliderCustomThumb> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalesNotifier>(builder: (context, notifier, _) {
      return SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 20.0,
          thumbShape: CustomThumbShape(),
        ),
        child: Slider(
          value: _currentSliderValue,
          min: 0,
          max: 80,
          divisions: 4,
          label: _currentSliderValue.round().toString(),
          activeColor: const Color(0xFFFE631B),
          inactiveColor: const Color(0xFFCDD1DC),
          onChanged: (value) {
            setState(() {
              _currentSliderValue = value;
            });
            notifier.setEvaluation(value.toInt());
          },
        ),
      );
    });
  }
}

class CustomThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(60, 60);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {Animation<double>? activationAnimation,
      Animation<double>? enableAnimation,
      bool isDiscrete = false,
      TextPainter? labelPainter,
      RenderBox? parentBox,
      SliderThemeData? sliderTheme,
      TextDirection? textDirection,
      double value = 0,
      double? textScaleFactor,
      Size? sizeWithOverflow}) {
    final Paint paint = Paint()
      ..color = const Color(0xFFFE814B)
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..addOval(Rect.fromCenter(center: center, width: 60, height: 60));

    context.canvas.drawPath(path, paint);
  }
}
