import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/AppConfigProvider.dart';

import 'LanguageBottomSheet.dart';
import 'ThemeButtomSheet.dart';

class TodoSettingsTpp extends StatefulWidget {
  @override
  State<TodoSettingsTpp> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<TodoSettingsTpp> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.language,
              style: TextStyle(
                  color: provider.isDarkMode() ? Colors.white : Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
                ShowLangageButtomSheet();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(provider.appLanguage == 'en' ? 'English' : 'العربية'),
                    Icon(Icons.arrow_drop_down_sharp)
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.theme,
              style: TextStyle(
                  color: provider.isDarkMode() ? Colors.white : Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
                ShowThemeButtomSheet();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(provider.appTheme == ThemeMode.light
                        ? AppLocalizations.of(context)!.light
                        : AppLocalizations.of(context)!.dark),
                    Icon(Icons.arrow_drop_down_sharp)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void ShowLangageButtomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return LanguageButtomSheet();
        });
  }

  void ShowThemeButtomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return ThemeButtomSheet();
        });
  }
}
