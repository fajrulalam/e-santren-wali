import 'package:esantrenwali_v1/Screens/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Screens/WidgetTree.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [Locale('id'), Locale('en', 'UK')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: ThemeData.light().copyWith(
          colorScheme:
              ThemeData().colorScheme.copyWith(primary: Colors.teal[700]),
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 1,
              titleTextStyle: TextStyle(
                  color: Colors.teal[700],
                  fontWeight: FontWeight.w500,
                  fontSize: 18))),
      locale: Locale('id'),
      initialRoute: WidgetTree.id,
      routes: {
        WidgetTree.id: (context) => WidgetTree(),
        HomePage.id: (context) => HomePage(),
      },
    );
  }
}
