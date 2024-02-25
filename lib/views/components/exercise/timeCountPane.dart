import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TimeCountPane extends StatefulWidget {
  final int currentTime;
  final int targetTime;

  const TimeCountPane({
    super.key,
    required this.currentTime,
    required this.targetTime,
  });

  @override
  State<TimeCountPane> createState() => _TimeCountPaneState();
}

class _TimeCountPaneState extends State<TimeCountPane>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: 20,
      child: Stack(
        children: [
          SizedBox(
            width: 200,
            height: 200,
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
              width: 200,
              height: 200,
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
                        value: (widget.currentTime / widget.targetTime) * 100,
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
                          positionFactor: 0.475,
                          angle: 90,
                          widget: Column(
                            children: <Widget>[
                              Text(
                                _formatTime(widget.currentTime),
                                style: const TextStyle(
                                  fontSize: 44,
                                  fontFamily: 'PlusBold',
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 110,
                                height: 4, //color is red
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              Text(
                                _formatTime(widget.targetTime),
                                style: const TextStyle(
                                  fontSize: 44,
                                  fontFamily: 'PlusBold',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
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

  String _formatTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
