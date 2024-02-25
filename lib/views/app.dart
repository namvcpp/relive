import 'package:fit_worker/l10n/l10n.dart';
import 'package:fit_worker/providers/notifiers/locale.notifier.dart';
import 'package:fit_worker/providers/store.dart';
import 'package:fit_worker/views/layouts/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Store store = Store();
  @override
  void initState() {
    super.initState();
    _initLocale();
  }

  void _initLocale() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? languageCode = prefs.getString('languageCode');
    // if (languageCode == null) {
    //   setState(() {
    //     _locale = Locale('en');
    //   });
    // } else {
    //   setState(() {
    //     _locale = Locale(languageCode);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<AppNotifier>.value(value: store.appNotifier),
        // ChangeNotifierProvider<PlanNotifier>.value(value: store.planNotifier),
        ChangeNotifierProvider<LocalesNotifier>.value(
            value: store.localesNotifier),
      ],
      child: Consumer<LocalesNotifier>(
        builder: (context, notifier, _) {
          return MaterialApp(
            title: 'Relive',
            supportedLocales: L10n.all,
            locale: notifier.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate, // Add this line
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routes: {
              '/today': (context) => const Navigation(
                    initialIndex: 0,
                  ),
            },
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
                  worstColor: Color(0xFFA18FFF),
                  poorColor: Color(0xFFFE814B),
                  fairColor: Color(0xFFA4DAF0),
                  goodColor: Color(0xFFFFCE5C),
                  excellentColor: Color(0xFF9BB068),
                ),
              ],
            ),
            home: const Navigation(),
            // home: const CheckUp(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class MyColors extends ThemeExtension<MyColors> {
  final Color? secondaryColor;
  final Color? exerciseColor;
  final Color? educationColor;
  final Color? primaryColor;
  final Color? worstColor;
  final Color? poorColor;
  final Color? fairColor;
  final Color? goodColor;
  final Color? excellentColor;

  MyColors(
      {this.secondaryColor,
      this.exerciseColor,
      this.educationColor,
      this.primaryColor,
      this.worstColor,
      this.poorColor,
      this.fairColor,
      this.goodColor,
      this.excellentColor});

  @override
  MyColors copyWith({
    Color? secondaryColor,
    Color? exerciseColor,
    Color? educationColor,
    Color? primaryColor,
    Color? worstColor,
    Color? poorColor,
    Color? fairColor,
    Color? goodColor,
    Color? excellentColor,
  }) {
    return MyColors(
      secondaryColor: secondaryColor ?? this.secondaryColor,
      primaryColor: primaryColor ?? this.primaryColor,
      exerciseColor: exerciseColor ?? this.exerciseColor,
      educationColor: educationColor ?? this.educationColor,
      worstColor: worstColor ?? this.worstColor,
      poorColor: poorColor ?? this.poorColor,
      fairColor: fairColor ?? this.fairColor,
      goodColor: goodColor ?? this.goodColor,
      excellentColor: excellentColor ?? this.excellentColor,
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
        worstColor: Color.lerp(worstColor, other.worstColor, t),
        poorColor: Color.lerp(poorColor, other.poorColor, t),
        fairColor: Color.lerp(fairColor, other.fairColor, t),
        goodColor: Color.lerp(goodColor, other.goodColor, t),
        excellentColor: Color.lerp(excellentColor, other.excellentColor, t),
      );
    }

    return this;
  }
}
