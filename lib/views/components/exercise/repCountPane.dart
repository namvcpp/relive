import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class RepsCountPane extends StatefulWidget {
  final int currentReps;
  final int targetReps;

  const RepsCountPane({
    super.key,
    required this.currentReps,
    required this.targetReps,
  });

  @override
  State<RepsCountPane> createState() => _RepsCountPaneState();
}

class _RepsCountPaneState extends State<RepsCountPane> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _positionAnimation = Tween<Offset>(
      begin: const Offset(20, 50),
      end: const Offset(115, 320),
    ).animate(_animationController);

    _sizeAnimation = Tween<double>(
      begin: 1.0, // Initial size
      end: 1.4, // Larger size
    ).animate(_animationController);
  }

  @override
  void didUpdateWidget(covariant RepsCountPane oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.currentReps != oldWidget.currentReps) {
      _animationController.forward().then((value) {
        Future.delayed(const Duration(seconds: 1), () {
          _animationController.reverse();
        });
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Positioned(
        top: _positionAnimation.value.dy,
        right: _positionAnimation.value.dx,
        child: Transform.scale(
          scale: _sizeAnimation.value,
          child: child!,
        ),
      ),
      child: Stack(
        children:[
          SizedBox(
            width: 150,
            height: 150,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(0, 0, 0, 0).withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: SizedBox(
              width: 150,
              height: 150,
              child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 2500,
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    startAngle: 270,
                    endAngle: 270,
                    radiusFactor: 1,
                    canScaleToFit: true,
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.175,
                      color: const Color.fromARGB(0, 0, 0, 0).withOpacity(0.2),
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: (widget.currentReps / widget.targetReps) * 100,
                        width: 0.175,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: const Color(0xFF7FD9FF),
                        enableAnimation: true,
                        animationDuration: 500,
                        animationType: AnimationType.linear,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        positionFactor: 0.05,
                        angle: 90,
                        widget: Text(
                          '${widget.currentReps} / ${widget.targetReps}',
                          style: const TextStyle(
                            fontSize: 44,
                            fontFamily: 'PlusBold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}