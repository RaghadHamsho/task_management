import 'package:flutter/material.dart';

import 'language_data_model.dart';

List<LanguageDataModel> languagesModels = [
  LanguageDataModel(
      id: 1, name: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: 'assets/images/ic_us.png'),
  LanguageDataModel(
      id: 2, name: 'Arabic', languageCode: 'ar', fullLanguageCode: 'ar-AR', flag: 'assets/images/ic_ar.png'),
];

abstract class BaseLanguage {
  static BaseLanguage of(BuildContext context) => Localizations.of<BaseLanguage>(context, BaseLanguage)!;

  String get appName;
  String get title;
  String get pleaseEnterYourCredentials;
  String get login;
  String get userName;
  String get loginMessage;
  String get password;
  String get enterEmail;
  String get enterPassword;
  String get forgotPassword;
  String get createAccount;
  String get signinButton;
  String get email;
  String get enterUserName;

  // Task Management
  String get allStatus;
  String get completed;
  String get pending;
  String get addNewTask;
  String get editTask;
  String get deleteTask;
  String get taskName;
  String get enterTaskName;
  String get taskDescription;
  String get enterTaskDescription;
  String get taskStatus;
  String get cancel;
  String get save;
  String get taskManagement;
  String get deleteConfirmation;
  String get deleteConfirmationMessage;
  String get delete;
  String get filterByStatus;
  String get selectStatus;
  String get name;
  String get description;
  String get createDate;
  String get status;
  String get actions;
  String get taskHelperDescription;

  // Dashboard
  String get dashboardTitle;
  String get overviewTasks;
  String get allTasks;
  String get completionRate;
  String get taskStatusChartTitle;
  String get tasksPerMonthChartTitle;
  String get legendCompleted;
  String get legendPending;
  String get tasks;
  String get alreadyHaveAccount;
  String get dontHaveAccount;
  String get pieChart;
  String get barChart;


  // network
  String get checkYourInternetConnection;

  String get noInternetConnection;

  String get invalidRequestCheckInput;

  String get unauthorizedPleaseLoginAgain;

  String get accessDeniedNoPermission;

  String get notFound;

  String get serverErrorTryAgainLater;

  String get requestFailed;

  String get unexpectedErrorOccurred;

  String get connectionTimeoutCheckInternet;

  String get requestTimeoutTryAgain;

  String get serverTimeoutTryAgain;

  String get requestWasCancelled;

  String get noInternetCheckNetwork;

  String get securityCertificateError;

  String get networkErrorTryAgain;

  String get unexpectedError;

  String get somethingWentWrong;

  //settings
  String get darkMode;
  String get lightMode;
  String get language;
  String get logout;


}
