import 'package:fit_worker/providers/notifiers/plan.notifier.dart';
import 'package:fit_worker/providers/store.dart';
import 'package:fit_worker/views/layouts/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Store store = Store();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlanNotifier>.value(value: store.planNotifier),
      ],
      child:  MaterialApp(
        title: 'Relive',
        theme: ThemeData(
            useMaterial3: true,
            textTheme: const TextTheme(
                bodyLarge: TextStyle(fontFamily: "PlusRegular")))
            .copyWith(
          extensions: <ThemeExtension<dynamic>>[
            MyColors(
              primaryColor: Color(0xFF1B2C56),
              secondaryColor: Color(0xFF646B7B),
              exerciseColor: Color(0xFFB9E9FD),
              educationColor: Color(0xFFFCEABC),
            ),
          ],
        ),
        home: const Navigation(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyColors extends ThemeExtension<MyColors> {
  final Color? secondaryColor;
  final Color? exerciseColor;
  final Color? educationColor;
  final Color? primaryColor;

  MyColors(
      {this.secondaryColor,
      this.exerciseColor,
      this.educationColor,
      this.primaryColor});

  @override
  MyColors copyWith(
      {Color? secondaryColor,
      Color? exerciseColor,
      Color? educationColor,
      Color? primaryColor}) {
    return MyColors(
      secondaryColor: secondaryColor ?? this.secondaryColor,
      primaryColor: primaryColor ?? this.primaryColor,
      exerciseColor: exerciseColor ?? this.exerciseColor,
      educationColor: educationColor ?? this.educationColor,
    );
  }

  @override
  MyColors lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is MyColors) {
      return MyColors(
        secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
        exerciseColor: Color.lerp(exerciseColor, other.exerciseColor, t),
        primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
        educationColor: Color.lerp(educationColor, other.educationColor, t),
      );
    }

    return this;
  }
}