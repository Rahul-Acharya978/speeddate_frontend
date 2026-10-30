import 'package:get/get.dart';

import '../modules/bottom/bindings/bottom_binding.dart';
import '../modules/bottom/views/bottom_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/chatSubscription/bindings/chat_subscription_binding.dart';
import '../modules/chatSubscription/views/chat_subscription_view.dart';
import '../modules/chatscreen/bindings/chatscreen_binding.dart';
import '../modules/chatscreen/views/chatscreen_view.dart';
import '../modules/completeYourProfile/bindings/complete_your_profile_binding.dart';
import '../modules/completeYourProfile/views/complete_your_profile_view.dart';
import '../modules/connectionProfilDetail/bindings/connection_profil_detail_binding.dart';
import '../modules/connectionProfilDetail/views/connection_profil_detail_view.dart';
import '../modules/editprofile/bindings/editprofile_binding.dart';
import '../modules/editprofile/views/editprofile_view.dart';
import '../modules/events/bindings/events_binding.dart';
import '../modules/events/views/events_view.dart';
import '../modules/freebookingSuccessful/bindings/freebooking_successful_binding.dart';
import '../modules/freebookingSuccessful/views/freebooking_successful_view.dart';
import '../modules/freeeventbooking/bindings/freeeventbooking_binding.dart';
import '../modules/freeeventbooking/views/freeeventbooking_view.dart';
import '../modules/freeeventselfi/bindings/freeeventselfi_binding.dart';
import '../modules/freeeventselfi/views/freeeventselfi_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/likesaveevent/bindings/likesaveevent_binding.dart';
import '../modules/likesaveevent/views/likesaveevent_view.dart';
import '../modules/live/bindings/live_binding.dart';
import '../modules/live/views/live_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/matchfound/bindings/matchfound_binding.dart';
import '../modules/matchfound/views/matchfound_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/otpscreen/bindings/otpscreen_binding.dart';
import '../modules/otpscreen/views/otpscreen_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/refundflow1/bindings/refundflow1_binding.dart';
import '../modules/refundflow1/views/refundflow1_view.dart';
import '../modules/refundflow2/bindings/refundflow2_binding.dart';
import '../modules/refundflow2/views/refundflow2_view.dart';
import '../modules/refundflow3/bindings/refundflow3_binding.dart';
import '../modules/refundflow3/views/refundflow3_view.dart';
import '../modules/savedconnection/bindings/savedconnection_binding.dart';
import '../modules/savedconnection/views/savedconnection_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/subscriptionsuccessful/bindings/subscriptionsuccessful_binding.dart';
import '../modules/subscriptionsuccessful/views/subscriptionsuccessful_view.dart';
import '../modules/userprofile/bindings/userprofile_binding.dart';
import '../modules/userprofile/views/userprofile_view.dart';
import '../modules/waitingroom/bindings/waitingroom_binding.dart';
import '../modules/waitingroom/views/waitingroom_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.OTPSCREEN,
      page: () => const OtpscreenView(),
      binding: OtpscreenBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETE_YOUR_PROFILE,
      page: () => const CompleteYourProfileView(),
      binding: CompleteYourProfileBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM,
      page: () => const BottomView(),
      binding: BottomBinding(),
    ),
    GetPage(
      name: _Paths.EVENTS,
      page: () => const EventsView(),
      binding: EventsBinding(),
    ),
    GetPage(
      name: _Paths.LIVE,
      page: () => const LiveView(),
      binding: LiveBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.USERPROFILE,
      page: () => const UserprofileView(),
      binding: UserprofileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.CHATSCREEN,
      page: () => const ChatscreenView(),
      binding: ChatscreenBinding(),
    ),
    GetPage(
      name: _Paths.SAVEDCONNECTION,
      page: () => const SavedconnectionView(),
      binding: SavedconnectionBinding(),
    ),
    GetPage(
      name: _Paths.WAITINGROOM,
      page: () => const WaitingroomView(),
      binding: WaitingroomBinding(),
    ),
    GetPage(
      name: _Paths.MATCHFOUND,
      page: () => const MatchfoundView(),
      binding: MatchfoundBinding(),
    ),
    GetPage(
      name: _Paths.REFUNDFLOW1,
      page: () => const Refundflow1View(),
      binding: Refundflow1Binding(),
    ),
    GetPage(
      name: _Paths.REFUNDFLOW2,
      page: () => const Refundflow2View(),
      binding: Refundflow2Binding(),
    ),
    GetPage(
      name: _Paths.REFUNDFLOW3,
      page: () => const Refundflow3View(),
      binding: Refundflow3Binding(),
    ),
    GetPage(
      name: _Paths.FREEEVENTBOOKING,
      page: () => const FreeeventbookingView(),
      binding: FreeeventbookingBinding(),
    ),
    GetPage(
      name: _Paths.FREEBOOKING_SUCCESSFUL,
      page: () => const FreebookingSuccessfulView(),
      binding: FreebookingSuccessfulBinding(),
    ),
    GetPage(
      name: _Paths.FREEEVENTSELFI,
      page: () => const FreeeventselfiView(),
      binding: FreeeventselfiBinding(),
    ),
    GetPage(
      name: _Paths.EDITPROFILE,
      page: () => const EditprofileView(),
      binding: EditprofileBinding(),
    ),
    GetPage(
      name: _Paths.LIKESAVEEVENT,
      page: () => const LikesaveeventView(),
      binding: LikesaveeventBinding(),
    ),
    GetPage(
      name: _Paths.CONNECTION_PROFIL_DETAIL,
      page: () => const ConnectionProfilDetailView(),
      binding: ConnectionProfilDetailBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_SUBSCRIPTION,
      page: () => const ChatSubscriptionView(),
      binding: ChatSubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTIONSUCCESSFUL,
      page: () => const SubscriptionsuccessfulView(),
      binding: SubscriptionsuccessfulBinding(),
    ),
  ];
}
