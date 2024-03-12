import 'package:get/get.dart';

import '../modules/client/bindings/client_binding.dart';
import '../modules/client/views/client_view.dart';
import '../modules/customer/bindings/customer_binding.dart';
import '../modules/customer/views/customer_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/driver/bindings/driver_binding.dart';
import '../modules/driver/views/driver_view.dart';
import '../modules/driver_number/bindings/driver_number_binding.dart';
import '../modules/driver_number/views/driver_number_view.dart';
import '../modules/invoice/bindings/invoice_binding.dart';
import '../modules/invoice/views/invoice_view.dart';
import '../modules/job/bindings/job_binding.dart';
import '../modules/job/views/job_view.dart';
import '../modules/license_type/bindings/license_type_binding.dart';
import '../modules/license_type/views/license_type_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/roaster/bindings/roaster_binding.dart';
import '../modules/roaster/views/roaster_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/onboarding_screen.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/truck/bindings/truck_binding.dart';
import '../modules/truck/views/truck_view.dart';
import '../modules/visa/bindings/visa_binding.dart';
import '../modules/visa/views/visa_view.dart';
import '../modules/wages/bindings/wages_binding.dart';
import '../modules/wages/views/wages_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingScreen(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.CLIENT,
      page: () => const ClientView(),
      binding: ClientBinding(),
    ),
    GetPage(
      name: _Paths.VISA,
      page: () => const VisaView(),
      binding: VisaBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER,
      page: () => const DriverView(),
      binding: DriverBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER,
      page: () => const CustomerView(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: _Paths.LICENSE_TYPE,
      page: () => const LicenseTypeView(),
      binding: LicenseTypeBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_NUMBER,
      page: () => const DriverNumberView(),
      binding: DriverNumberBinding(),
    ),
    GetPage(
      name: _Paths.WAGES,
      page: () => const WagesView(),
      binding: WagesBinding(),
    ),
    GetPage(
      name: _Paths.TRUCK,
      page: () => const TruckView(),
      binding: TruckBinding(),
    ),
    GetPage(
      name: _Paths.JOB,
      page: () => const JobView(),
      binding: JobBinding(),
    ),
    GetPage(
      name: _Paths.ROASTER,
      page: () => const RoasterView(),
      binding: RoasterBinding(),
    ),
    GetPage(
      name: _Paths.INVOICE,
      page: () => const InvoiceView(),
      binding: InvoiceBinding(),
    ),
  ];
}
