import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:mizban/application/shared_preferences.dart';
import 'package:mizban/main.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView>
    with AutomaticKeepAliveClientMixin<SettingView> {
  final double itemHeight = 54;
  ThemeData? _themeData;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    _themeData = DynamicTheme.of(context)?.theme;

    return Container(
        color: _themeData?.backgroundColor,
        child: ListView(
          children: [languageItem(context), themeItem(context)],
        ));
  }

  /// Language Item
  MaterialButton languageItem(BuildContext context) {
    return MaterialButton(
      height: itemHeight,
      onPressed: showLangPicker,
      child: Row(
        children: [
          Text("language").tr(),
          Spacer(),
          Text(
            "languages." + context.locale.languageCode,
            style: TextStyle(color: _themeData?.accentColor),
          ).tr()
        ],
      ),
    );
  }

  /// Theme Item
  MaterialButton themeItem(BuildContext context) {
    return MaterialButton(
      height: itemHeight,
      onPressed: showAppearancePicker,
      child: Row(
        children: [
          Text("appearance").tr(),
          Spacer(),
          Text(
              DynamicTheme.of(this.context)
                      ?.theme
                      .brightness
                      .toString()
                      .toLowerCase()
                      .tr() ??
                  "",
              style: TextStyle(color: _themeData?.accentColor))
        ],
      ),
    );
  }

  void showAppearancePicker() {
    /// Do not change indexes!!!
    List<String> appearances = [
      Brightness.light.toString().toLowerCase().tr(),
      Brightness.dark.toString().toLowerCase().tr()
    ];

    int selectedIndex = appearances.indexWhere((element) =>
        element.split('-')[0] ==
        tr(DynamicTheme.of(this.context)
                ?.theme
                .brightness
                .toString()
                .toLowerCase() ??
            ""));

    new Picker(
            headerColor: _themeData?.dialogBackgroundColor,
            textStyle: _themeData?.textTheme.bodyText1,
            backgroundColor: _themeData?.dialogBackgroundColor,
            selecteds: [selectedIndex],
            confirmText: "confirm".tr(),
            cancelText: "cancel".tr(),
            adapter: PickerDataAdapter<String>(pickerdata: appearances),
            changeToFirst: true,
            hideHeader: false,
            onConfirm: pickAppearance)
        .showModal(this.context, _themeData, true);
  }

  void showLangPicker() {
    /// Do not change indexes!!!
    List<String> languages = ["languages.en".tr(), "languages.fa".tr()];

    int selectedIndex = languages.indexWhere((element) =>
        element.split('-')[0] ==
        tr("languages." + this.context.locale.languageCode));

    new Picker(
            headerColor: _themeData?.dialogBackgroundColor,
            textStyle: _themeData?.textTheme.bodyText1,
            backgroundColor: _themeData?.dialogBackgroundColor,
            selecteds: [selectedIndex],
            confirmText: "confirm".tr(),
            cancelText: "cancel".tr(),
            adapter: PickerDataAdapter<String>(pickerdata: languages),
            changeToFirst: true,
            hideHeader: false,
            onConfirm: pickLanguage)
        .showModal(this.context, _themeData, true);
  }

  void pickLanguage(Picker picker, List value) {
    switch (value[0].toString()) {

      /// English
      case "0":
        UserDefaults.shared.setCurrentLocale("en-US");
        setState(() {
          EasyLocalization.of(this.context)!.setLocale(Locale('en', 'US'));
        });
        break;

      /// Farsi
      case "1":
        UserDefaults.shared.setCurrentLocale("fa-IR");
        setState(() {
          EasyLocalization.of(this.context)!.setLocale(Locale("fa", "IR"));
        });
        break;
    }
  }

  void pickAppearance(Picker picker, List value) {
    switch (value[0].toString()) {

      /// Light
      case "0":
        UserDefaults.shared.setAppearance(false);
        setState(() {
          DynamicTheme.of(context)?.setTheme(AppThemes.Light);
        });
        break;

      /// Dark
      case "1":
        UserDefaults.shared.setAppearance(true);
        setState(() {
          DynamicTheme.of(context)?.setTheme(AppThemes.Dark);
        });
        break;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
