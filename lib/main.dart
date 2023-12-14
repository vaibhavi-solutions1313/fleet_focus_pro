import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'app/modules/splash/controllers/splash_controller.dart';
import 'app/routes/app_pages.dart';
import 'constant.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  FirebaseMessaging.instance.getInitialMessage().then(
        (value) => FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          print('Got a message whilst in the foreground!');
          print('Message data: ${message.data}');

          if (message.notification != null) {
            print('Message also contained a notification: ${message.notification}');
          }
        }),
      );
}

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  /// STRIPE STARTED
  Stripe.publishableKey = Configs.stripePublishableKey;

  /// STRIPE ENDS
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GlobalLoaderOverlay(
          child: LoaderOverlay(
            useDefaultLoading: false,
            overlayWidget: const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
            overlayColor: Colors.white12,
            overlayOpacity: 0.8,
            child: GetMaterialApp(
              title: "Fleet Focus Pro",
              debugShowCheckedModeBanner: false,
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              enableLog: true,
              defaultTransition: Transition.cupertino,
              opaqueRoute: Get.isOpaqueRouteDefault,
              popGesture: Get.isPopGestureEnable,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: OurColor.highlightBG),
                useMaterial3: true,
                fontFamily: GoogleFonts.lato().fontFamily,
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(
                    color: Colors.black54
                  )
                )
              ),
              onReady: () async {
                final splashControl = Get.find<SplashController>();
                await splashControl.getTokenBasedData();
              },
            ),
          ),
        );
      },
    ),
  );
}
