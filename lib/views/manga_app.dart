import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:manga_app/blocs/language/language_bloc.dart';
import 'package:manga_app/common/constants/languages.dart';
import 'package:manga_app/common/localization.dart';
import 'package:manga_app/di/get_it.dart';
import 'package:manga_app/views/screens/home_screen.dart';
import 'package:manga_app/views/themes/app_color.dart';
import 'package:manga_app/views/themes/text_theme.dart';

class MangaApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MangaAppState createState() => _MangaAppState();
}

class _MangaAppState extends State<MangaApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  LanguageBloc _languageBloc;

  @override
  void initState() {
    super.initState();
    FlutterStatusbarManager.setStyle(StatusBarStyle.DARK_CONTENT);
    FlutterStatusbarManager.setColor(Colors.white, animated: true);
    _languageBloc = getItInstance<LanguageBloc>();
  }

  @override
  void dispose() {
    _languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageBloc>.value(
        value: _languageBloc,
        child:
            BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
          if (state is LanguageLoaded) {
            return GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
                    FocusManager.instance.primaryFocus.unfocus();
                  }
                },
                child: MaterialApp(
                  title: 'Manga App',
                  debugShowCheckedModeBanner: false,
                  supportedLocales:
                      Languages.languages.map((e) => Locale(e.code)).toList(),
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                  ],
                  theme: ThemeData(
                    // This is the theme of your application.
                    //
                    // Try running your application with "flutter run". You'll see the
                    // application has a blue toolbar. Then, without quitting the app, try
                    // changing the primarySwatch below to Colors.green and then invoke
                    // "hot reload" (press "r" in the console where you ran "flutter run",
                    // or simply save your changes to "hot reload" in a Flutter IDE).
                    // Notice that the counter didn't reset back to zero; the application
                    // is not restarted.
                    primaryColor: AppColors.primary,
                    accentColor: AppColors.primary,
                    // This makes the visual density adapt to the platform that you run
                    // the app on. For desktop platforms, the controls will be smaller and
                    // closer together (more dense) than on mobile platforms.
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    textTheme: AppText.getTextTheme(),
                  ),
                  home: HomeScreen(),
                ));
          }
          return SizedBox.shrink();
        }));
  }
}
