import 'package:flutter/material.dart';
import 'package:uni/features/browse/presentation/views/browse_view.dart';
import 'package:uni/features/faheem/presentation/views/faheem_chat_view.dart';
import 'package:uni/features/fav/presentation/views/fav_view.dart';
import 'package:uni/features/guide/presentation/views/guide_articles_view.dart';
import 'package:uni/features/guide/presentation/views/guide_podcasts_view.dart';
import 'package:uni/features/guide/presentation/views/guide_videos_view.dart';
import 'package:uni/features/guide/presentation/views/guide_view.dart';
import 'package:uni/features/home/presentation/views/main_view.dart';
import 'package:uni/features/home/presentation/views/widgets/home_view.dart';
import 'package:uni/features/notifications/presentation/views/notifications_view.dart';
import 'package:uni/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:uni/features/profile/presentation/views/contact_us_view.dart';
import 'package:uni/features/profile/presentation/views/personal_data_view.dart';
import 'package:uni/features/profile/presentation/views/profile_view.dart';
import 'package:uni/features/profile/presentation/views/security_view.dart';
import 'package:uni/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    case MainView.routeName:
      return MaterialPageRoute(builder: (context) => const MainView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case FavView.routeName:
      return MaterialPageRoute(builder: (context) => const FavView());
    case ProfileView.routeName:
      return MaterialPageRoute(builder: (context) => const ProfileView());
    case PersonalDataView.routeName:
      return MaterialPageRoute(builder: (context) => const PersonalDataView());
    case SecurityView.routeName:
      return MaterialPageRoute(builder: (context) => const SecurityView());
    case ContactUsView.routeName:
      return MaterialPageRoute(builder: (context) => const ContactUsView());
    case GuideView.routeName:
      return MaterialPageRoute(builder: (context) => const GuideView());
    case GuideVideosView.routeName:
      return MaterialPageRoute(builder: (context) => const GuideVideosView());
    case GuidePodcastsView.routeName:
      return MaterialPageRoute(builder: (context) => const GuidePodcastsView());
    case GuideArticlesView.routeName:
      return MaterialPageRoute(builder: (context) => const GuideArticlesView());
    case BrowseView.routeName:
      return MaterialPageRoute(builder: (context) => const BrowseView());
    case NotificationsView.routeName:
      return MaterialPageRoute(builder: (context) => const NotificationsView());
    case FaheemChatView.routeName:
      return MaterialPageRoute(builder: (context) => const FaheemChatView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
