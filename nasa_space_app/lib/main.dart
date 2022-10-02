import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nasa_space_app/UI/Screens/get_started.dart';
import 'package:nasa_space_app/UI/Screens/searchscreen.dart';
import 'package:nasa_space_app/constant.dart';

import 'models/logic/cubit/search_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.removeAfter(initialization);

  runApp(const MyApp());
}

Future initialization(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: MaterialApp(
          title: 'NASART',
          theme: ThemeData(
            textTheme: TextTheme(
                displaySmall: TextStyle(
                  color: darkblue.withOpacity(0.7),
                  fontSize: 10,
                  fontFamily: 'Nasalization',
                ),
                labelSmall: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Nasalization',
                ),
                titleSmall: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 16,
                  fontFamily: 'Nasalization',
                ),
                bodySmall: TextStyle(
                  color: darkblue.withOpacity(0.8),
                  fontSize: 15,
                  fontFamily: 'Nasalization',
                ),
                labelMedium: TextStyle(
                  color: darkblue30,
                  fontSize: 15,
                  fontFamily: 'Nasalization',
                ),
                bodyMedium: TextStyle(
                  color: primaryblue,
                  fontSize: 20,
                  fontFamily: 'Nasalization',
                ),
                titleLarge: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Nasa',
                ),
                titleMedium: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 18,
                  fontFamily: 'Nasalization',
                )),
            primarySwatch: Colors.blue,
          ),
          routes: {Search.route: ((context) => Search())},
          home: const GetStarted()),
    );
  }
}
