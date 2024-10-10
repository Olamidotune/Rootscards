// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/blocs/auth/auth_bloc.dart';
import 'package:rootscards/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:rootscards/blocs/otp/otp_bloc.dart';
import 'package:rootscards/blocs/sign_up/bloc/sign_up_bloc.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/src/presentation/screens/auth/sign_up/second_sign_up_screen.dart';
import '../src/presentation/get_started_screen.dart';
import '../src/presentation/screens/auth/passowrd/forgot_password.dart';
import '../src/presentation/screens/auth/passowrd/password_recovery.dart';
import '../src/presentation/screens/auth/otp.dart';
import '../src/presentation/screens/auth/sign_in/sign_in.dart';
import 'src/presentation/screens/auth/sign_up/sign_up.dart';
import '../src/presentation/screens/onboarding/onboarding_screen.dart';
import '../src/presentation/screens/space/space_screen.dart';
import '../src/presentation/screens/splash_screen/splash_screen.dart';
import 'package:rootscards/repos/repos.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env.production");
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository = AuthRepository();

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MultiRepositoryProvider(
                providers: [
                  RepositoryProvider(
                    create: (context) => AuthRepository(),
                  )
                ],
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => AuthBloc(
                        authRepository: context.read<AuthRepository>(),
                      ),
                    ),
                    BlocProvider(
                      create: (context) => OtpAuthBloc(authRepository),
                    ),
                    BlocProvider(
                      create: (context) => ForgotPasswordBloc(authRepository),
                    ),
                    BlocProvider(
                        create: (context) => SignUpBloc(authRepository)),
                  ],
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      fontFamily: 'Lato',
                      // scaffoldBackgroundColor: BLACK,
                      useMaterial3: true,
                      textTheme: TextTheme(
                        bodyMedium: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14.sp,
                        ),
                        bodySmall: TextStyle(
                          fontSize: 12.sp,
                          color: BLACK,
                          fontFamily: 'Lato',
                        ),
                        titleLarge: TextStyle(color: Colors.black),
                        titleMedium: TextStyle(color: Colors.black),
                        titleSmall: TextStyle(color: Colors.black),
                        displayLarge: TextStyle(color: Colors.black),
                        displayMedium: TextStyle(color: Colors.black),
                        displaySmall: TextStyle(color: Colors.black),
                      ),
                    ),
                    // darkTheme: ThemeData(
                    //   brightness: Brightness.dark,
                    //   fontFamily: 'McLaren',
                    //   textTheme: const TextTheme(
                    //     bodySmall: TextStyle(color: Colors.white),
                    //     bodyLarge: TextStyle(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //     bodyMedium: TextStyle(color: Colors.white),
                    //     titleLarge: TextStyle(color: Colors.white),
                    //     titleMedium: TextStyle(color: Colors.white),
                    //     titleSmall: TextStyle(color: Colors.white),
                    //     displayLarge: TextStyle(color: Colors.white),
                    //     displayMedium: TextStyle(color: Colors.white),
                    //     displaySmall: TextStyle(color: Colors.white),
                    //   ),
                    //   scaffoldBackgroundColor: Colors.white,
                    // ),
                    home: SplashScreen(),
                    routes: {
                      SplashScreen.routeName: (context) => SplashScreen(),
                      OnboardingScreen.routeName: (context) =>
                          OnboardingScreen(),
                      SignUpScreen.routeName: (context) => SignUpScreen(),
                      SignInScreen.routeName: (context) => SignInScreen(),
                      GetStartedScreen.routeName: (context) =>
                          GetStartedScreen(),
                      ForgotPasswordScreen.routeName: (context) =>
                          ForgotPasswordScreen(),
                      OtpScreen.routeName: (context) => OtpScreen(),
                      SpaceScreen.routeName: (context) => SpaceScreen(),
                      PasswordRecovery.routeName: (context) =>
                          PasswordRecovery(),
                      SecondSignUpScreen.routeName: (context) =>
                          SecondSignUpScreen(),
                    },
                  ),
                )));
  }
}
