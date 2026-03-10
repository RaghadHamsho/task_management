import '../languages.dart';

class LanguageAr extends BaseLanguage {
  @override
  String get appName => 'Task Flow';
  @override
  String get title => ' إدارة المهام الذكية';

  @override
  String get pleaseEnterYourCredentials => 'يرجى إدخال بيانات الاعتماد الخاصة بك';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get userName => 'اسم المستخدم';

  @override
  String get loginMessage => 'يرجى إدخال اسم المستخدم وكلمة المرور';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enterEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get enterPassword => 'أدخل كلمة المرور';
  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get enterUserName => 'أدخل اسم المستخدم';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get signinButton => 'تسجيل الدخول';

  @override
  String get allStatus => 'جميع الحالات';

  @override
  String get completed => 'مكتمل';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get addNewTask => 'إضافة مهمة جديدة';

  @override
  String get editTask => 'تعديل المهمة';

  @override
  String get deleteTask => 'حذف المهمة';

  @override
  String get taskName => 'اسم المهمة';

  @override
  String get enterTaskName => 'أدخل اسم المهمة';

  @override
  String get taskDescription => 'وصف المهمة';

  @override
  String get enterTaskDescription => 'أدخل وصف المهمة';

  @override
  String get taskStatus => 'حالة المهمة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get taskManagement => 'إدارة المهام';

  @override
  String get deleteConfirmation => 'تأكيد الحذف';

  @override
  String get deleteConfirmationMessage =>
      'هل أنت متأكد أنك تريد حذف هذه المهمة؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get delete => 'حذف';

  @override
  String get filterByStatus => 'تصفية حسب الحالة:';

  @override
  String get selectStatus => 'اختر الحالة';

  @override
  String get name => 'الاسم';

  @override
  String get description => 'الوصف';

  @override
  String get createDate => 'تاريخ الإنشاء';

  @override
  String get status => 'الحالة';

  @override
  String get actions => 'الإجراءات';

  @override
  String get taskHelperDescription => 'أضف وعدّل واحذف مهامك بسهولة';

  // Dashboard
  @override
  String get dashboardTitle => 'لوحة التحكم';

  @override
  String get overviewTasks => 'نظرة عامة على المهام والإحصاءات';

  @override
  String get allTasks => 'جميع المهام';

  @override
  String get completionRate => 'نسبة الإنجاز';

  @override
  String get taskStatusChartTitle => 'حالة المهمة';

  @override
  String get tasksPerMonthChartTitle => 'المهام لكل شهر';

  @override
  String get legendCompleted => 'مكتمل';

  @override
  String get legendPending => 'قيد الانتظار';
  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';
  @override
  String get tasks => 'المهام';
  @override
  String get pieChart => 'مخطط دائري';

  @override
  String get barChart => 'مخطط عامودي';

  // network
  @override
  String get checkYourInternetConnection => 'تحقق من اتصالك بالإنترنت';

  @override
  String get noInternetConnection => 'لا يوجد اتصال بالإنترنت';

  @override
  String get invalidRequestCheckInput => 'طلب غير صالح. يرجى التحقق من المدخلات.';

  @override
  String get unauthorizedPleaseLoginAgain => 'غير مصرح. يرجى تسجيل الدخول مرة أخرى.';

  @override
  String get accessDeniedNoPermission => 'تم رفض الوصول. ليس لديك إذن.';

  @override
  String get notFound => 'غير موجود.';

  @override
  String get serverErrorTryAgainLater => 'خطأ في الخادم. يرجى المحاولة لاحقاً.';

  @override
  String get requestFailed => 'فشل الطلب.';

  @override
  String get unexpectedErrorOccurred => 'حدث خطأ غير متوقع.';

  @override
  String get connectionTimeoutCheckInternet => 'انتهت مهلة الاتصال. يرجى التحقق من الإنترنت.';

  @override
  String get requestTimeoutTryAgain => 'انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.';

  @override
  String get serverTimeoutTryAgain => 'انتهت مهلة الخادم. يرجى المحاولة مرة أخرى.';

  @override
  String get requestWasCancelled => 'تم إلغاء الطلب';

  @override
  String get noInternetCheckNetwork => 'لا يوجد اتصال بالإنترنت. يرجى التحقق من شبكتك.';

  @override
  String get securityCertificateError => 'خطأ في شهادة الأمان';

  @override
  String get networkErrorTryAgain => 'خطأ في الشبكة. يرجى المحاولة مرة أخرى.';

  @override
  String get unexpectedError => 'خطأ غير متوقع';

  @override
  String get somethingWentWrong => "حدث خطأ ما";
  //settings
  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get language => 'اللغة';

  @override
  String get logout => 'تسجيل الخروج';
}