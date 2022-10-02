import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nasa_space_app/UI/Screens/get_started.dart';
import 'package:nasa_space_app/UI/Screens/searchscreen.dart';
import 'package:nasa_space_app/constant.dart';
import 'package:nasa_space_app/repo/auth_repo.dart';

import 'UI/Screens/authscreen.dart';
import 'logic/cubit/bloc/authentication_bloc.dart';
import 'logic/cubit/cubit/imageoftheday_cubit.dart';
import 'logic/cubit/search_cubit.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp(userRepository: UserRepository()));
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.userRepository,
  }) : super(key: key);
  final UserRepository userRepository;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthenticationBloc authenticationBloc;
  UserRepository get userRepository => widget.userRepository;
  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    authenticationBloc.add(AppStarted());

    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
                BlocProvider(
          create: (_) => ImageofthedayCubit(),
        ),

        BlocProvider(
          create: (_) => SearchCubit(),
        ),
        BlocProvider(
          create: (_) => authenticationBloc,
        ),
      ],
      child: MaterialApp(
          title: 'NASART',
          theme: ThemeData(
            textTheme: TextTheme(
              headlineSmall:                TextStyle(
                  color: darkblue.withOpacity(0.4),
                  fontSize: 14,
                  fontFamily: 'Nasalization',
                ),
 
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
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is! AuthenticationUninitialized) {
                  FlutterNativeSplash.remove();
                }
                return AuthScreen(userRepository: userRepository,);
              },
            )
          
          
          
          ),
    );
  }
}
