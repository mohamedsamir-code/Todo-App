import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/My_Theme_Data.dart';
import 'package:todo_app/Ui/Home/HomeScrean.dart';
import 'package:todo_app/Ui/Splash/splash.dart';

import 'Provider/AppConfigProvider.dart';
import 'Ui/Home/List_Tap/Edit_List_Widget.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var provider = AppConfigProvider();
  provider.loadSettingConfig();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (buildContext) {
        return provider;
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      locale: Locale(provider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.appTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScrean.routeName: (context) => HomeScrean(),
        Edit_List_Widget.routeName: (context) => Edit_List_Widget(),
        Splash.routeName: (context) => Splash(),
      },
      initialRoute: Splash.routeName,
    );
  }
}
