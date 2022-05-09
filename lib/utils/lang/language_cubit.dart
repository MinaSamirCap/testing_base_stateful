import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:testing_base_stateful/prefs/pref_manager.dart';
import 'package:testing_base_stateful/utils/lang/app_localization.dart';

class LangCubit extends Cubit<Locale> {
  LangCubit() : super(const Locale(CODE_EN)) {
    getDefaultLanguage();
  }

  void changeLanguage(Language selectedLanguage) async {
    final defaultLanguageCode = await PrefManager.getLang();

    if (selectedLanguage == Language.ar && defaultLanguageCode != CODE_AR) {
      emit(Locale(CODE_AR));
      await PrefManager.setLang(CODE_AR);
    } else if (selectedLanguage == Language.en &&
        defaultLanguageCode != CODE_EN) {
      emit(Locale(CODE_EN));
      await PrefManager.setLang(CODE_EN);
    }
  }

  void getDefaultLanguage() async {
    final defaultLanguageCode = await PrefManager.getLang();
    Locale locale;
    if (defaultLanguageCode == null) {
      locale = Locale(defaultSystemLocale);
      await PrefManager.setLang(locale.languageCode);
    } else {
      locale = Locale(defaultLanguageCode);
      if (locale.languageCode == CODE_EN) {
        await PrefManager.setLang(locale.languageCode);
      } else {
        await PrefManager.setLang(locale.languageCode);
      }
    }
    emit(locale);
  }

  String get defaultSystemLocale => Platform.localeName.substring(0, 2);
}

enum Language { en, ar }
