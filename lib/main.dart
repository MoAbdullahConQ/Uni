import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uni/core/helper_functions/on_generate_routes.dart';
import 'package:uni/core/services/custom_bloc_observer.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/services/shared_preferences_singleton.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_fonts.dart';
import 'package:uni/features/fav/presentation/manager/fav_cubit/fav_cubit.dart';
import 'package:uni/features/notifications/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:uni/features/splash/presentation/views/splash_view.dart';
import 'package:uni/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Prefs().init();

  Bloc.observer = CustomBlocObserver();

  await setupGetIt();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<FavCubit>()),
        BlocProvider.value(
          value: getIt<NotificationsCubit>()..getNotifications(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: AppFonts.arabicFont,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('ar'),
        builder: (context, child) =>
            Directionality(textDirection: TextDirection.rtl, child: child!),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        initialRoute: SplashView.routeName,
      ),
    );
  }
}
