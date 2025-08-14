
import '../features/splash/splash_page.dart';
import '../navigation_menu.dart';
import '../utils/helpers/path_provider.dart';
import 'app_pages.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: AppPages.splash,
      page: () => const SplashPage(),
    ),
    // GetPage(
    //   name: AppPages.login,
    //   binding: LoginBindings(),
    //   page: () => const LoginPage(),
    // ),
    // GetPage(
    //   name: AppPages.dashboard,
    //   binding: DashboardBindings(),
    //   page: () => const DashboardPage(),
    // ),
    // GetPage(
    //   name: AppPages.staff,
    //   binding: AccountsBindings(),
    //   page: () => const AccountsPage(),
    // ),
    // GetPage(
    //   name: AppPages.productionPlan,
    //   binding: ProductionPlanBindings(),
    //   page: () => const ProductionPlanPage(),
    // ),
    // // GetPage(name: AppPages.courseDetail, page: () => CourseDetailPage()),
    // GetPage(
    //   name: AppPages.production,
    //   binding: ProductionBindings(),
    //   page: () => const ProductionPage(),
    // ),
    // GetPage(
    //   name: AppPages.qualityControl,
    //   binding: QualityControlBindings(),
    //   page: () => const QualityControlPage(),
    // ),
    // GetPage(
    //   name: AppPages.marketing,
    //   binding: MarketingBindings(),
    //   page: () => const MarketingPage(),
    // ),
    // GetPage(name: AppPages.arrivedPage, page: () => ArrivedPage()),
    //
    // // GetPage(name: AppPages.notesPage, page: () => NotesPage()),
    // GetPage(
    //   name: AppPages.customerCompletePage,
    //   page: () => CompleteCustomerPage(),
    // ),
    // GetPage(
    //   name: AppPages.marketingDownloadPage,
    //   page: () => MarketingDownloadPage(),
    // ),
    // GetPage(
    //   name: AppPages.materialManagement,
    //   binding: MaterialManagementBindings(),
    //   page: () => const MaterialManagementPage(),
    // ),
    //
    // GetPage(
    //   name: AppPages.attendance,
    //   binding: AttendanceBindings(),
    //   page: () => const AttendancePage(),
    // ),
    // GetPage(
    //   name: AppPages.purchase,
    //   binding: PurchaseBindings(),
    //   page: () => PurchasePage(),
    // ),
    GetPage(
      name: AppPages.bottomNav,
      // bindings: [
      //   DashboardBindings(),
      //   AccountsBindings(),
      //   ProductionBindings(),
      //   QualityControlBindings(),
      //   BottomNavBindings(),
      // ],
      page: () => NavigationMenu(),
    ),
  ];
}
