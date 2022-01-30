// import 'package:get/get.dart' show GetPage, Transition;
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:warranty_track/app/middlewares/auth_middleware.dart';
import 'package:warranty_track/app/modules/auth/binding/login_binding.dart';
import 'package:warranty_track/app/modules/auth/view/login_page.dart';
import 'package:warranty_track/app/modules/auth/view/signup_page.dart';
import 'package:warranty_track/app/modules/category/view/categories_screen.dart';
import 'package:warranty_track/app/modules/feedback/view/feedback_screen.dart';
import 'package:warranty_track/app/modules/home/bindings/home_binding.dart';
import 'package:warranty_track/app/modules/home/view/home_screen.dart';
import 'package:warranty_track/app/modules/settings/view/settings_screen.dart';
import 'package:warranty_track/app/modules/transaction/binding/transaction_binding.dart';
import 'package:warranty_track/app/modules/transaction/view/transaction_screen.dart';
import 'package:warranty_track/app/modules/warranty/binding/warranty_binding.dart';
import 'package:warranty_track/app/modules/warranty/view/warranty_screen.dart';
import 'package:warranty_track/app/routes/routes.dart';

class RoutePage {
  static const rInitial = Routes.rLOGIN;

  static final routes = [
    GetPage(
      name: Routes.rHome,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.rLOGIN,
      page: () => const LoginView(),
      // binding: LoginBinding(),
      // middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.rREGISTER,
      page: () => const SignUpPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.rTRANSECTION,
      binding: TransactionBinding(),
      page: () => const TransactionView(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.rCATEGORY,
      // binding: TransactionBinding(),
      page: () => CategoriesScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.rWARRANTY,
      page: () => const WarrantyScreen(),
      binding: WarrantyBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.rFeedback,
      page: () => const FeedbackScreen(),
      // binding: WarrantyBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.rSettings,
      page: () => const SettingsScreen(),
      // binding: WarrantyBinding(),
      middlewares: [AuthMiddleware()],
    ),
    // GetPage(name: Routes.RATING, page: () => RatingView(), binding: RatingBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.CHAT, page: () => ChatsView(), binding: RootBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.SETTINGS, page: () => SettingsView(), binding: SettingsBinding()),
    // GetPage(name: Routes.SETTINGS_ADDRESSES, page: () => AddressesView(), binding: SettingsBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.SETTINGS_THEME_MODE, page: () => ThemeModeView(), binding: SettingsBinding()),
    // GetPage(name: Routes.SETTINGS_LANGUAGE, page: () => LanguageView(), binding: SettingsBinding()),
    // GetPage(name: Routes.SETTINGS_ADDRESS_PICKER, page: () => AddressPickerView()),
    // // GetPage(name: Routes.PROFILE, page: () => ProfileView(), binding: ProfileBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.CATEGORY, page: () => CategoryView(), binding: CategoryBinding()),
    // GetPage(name: Routes.CATEGORIES, page: () => CategoriesView(), binding: CategoryBinding()),
    // GetPage(name: Routes.LOGIN, page: () => LoginView(), binding: AuthBinding(), transition: Transition.zoom),
    // GetPage(name: Routes.REGISTER, page: () => RegisterView(), binding: AuthBinding()),
    // GetPage(name: Routes.FORGOT_PASSWORD, page: () => ForgotPasswordView(), binding: AuthBinding()),
    // GetPage(name: Routes.PHONE_VERIFICATION, page: () => PhoneVerificationView(), binding: AuthBinding()),
    // GetPage(name: Routes.E_SERVICE, page: () => EServiceView(), binding: EServiceBinding(), transition: Transition.downToUp),
    // GetPage(name: Routes.BOOK_E_SERVICE, page: () => BookEServiceView(), binding: BookEServiceBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.BOOKING_SUMMARY, page: () => BookingSummaryView(), binding: BookEServiceBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.CHECKOUT, page: () => CheckoutView(), binding: CheckoutBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.CONFIRMATION, page: () => ConfirmationView(), binding: CheckoutBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.SEARCH, page: () => SearchView(), binding: RootBinding(), transition: Transition.downToUp),
    // GetPage(name: Routes.NOTIFICATIONS, page: () => NotificationsView(), binding: NotificationsBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.FAVORITES, page: () => FavoritesView(), binding: FavoritesBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.PRIVACY, page: () => PrivacyView(), binding: HelpPrivacyBinding()),
    // GetPage(name: Routes.HELP, page: () => HelpView(), binding: HelpPrivacyBinding()),
    // GetPage(name: Routes.E_PROVIDER, page: () => EProviderView(), binding: EProviderBinding()),
    // GetPage(name: Routes.E_PROVIDER_E_SERVICES, page: () => EProviderEServicesView(), binding: EProviderBinding()),
    // GetPage(name: Routes.BOOKING, page: () => BookingView(), binding: RootBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.PAYPAL, page: () => PayPalViewWidget(), binding: CheckoutBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.RAZORPAY, page: () => RazorPayViewWidget(), binding: CheckoutBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.STRIPE, page: () => StripeViewWidget(), binding: CheckoutBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.STRIPE_FPX, page: () => StripeFPXViewWidget(), binding: CheckoutBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.PAYSTACK, page: () => PayStackViewWidget(), binding: CheckoutBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.FLUTTERWAVE, page: () => FlutterWaveViewWidget(), binding: CheckoutBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.CASH, page: () => CashViewWidget(), binding: CheckoutBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.WALLET, page: () => WalletViewWidget(), binding: CheckoutBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.CUSTOM_PAGES, page: () => CustomPagesView(), binding: CustomPagesBinding()),
    // GetPage(name: Routes.GALLERY, page: () => GalleryView(), binding: GalleryBinding(), transition: Transition.fadeIn),
    // GetPage(name: Routes.WALLETS, page: () => WalletsView(), binding: WalletsBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: Routes.WALLET_FORM, page: () => WalletFormView(), binding: WalletsBinding(), middlewares: [AuthMiddleware()]),
  ];
}
