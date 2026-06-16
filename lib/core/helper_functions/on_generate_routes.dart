import 'package:flutter/material.dart';
import 'package:uni/features/auth/presentation/views/forgot_password_view.dart';
import 'package:uni/features/auth/presentation/views/login_view.dart';
import 'package:uni/features/auth/presentation/views/otp_view.dart';
import 'package:uni/features/auth/presentation/views/reset_password_view.dart';
import 'package:uni/features/auth/presentation/views/setup_view.dart';
import 'package:uni/features/auth/presentation/views/sign_up_view.dart';
import 'package:uni/features/browse/presentation/views/browse_view.dart';
import 'package:uni/features/faheem/presentation/views/faheem_chat_view.dart';
import 'package:uni/features/faheem/presentation/views/faheem_history_view.dart';
import 'package:uni/features/fav/presentation/views/fav_view.dart';
import 'package:uni/features/guide/domain/entities/guide_article_entity.dart';
import 'package:uni/features/guide/presentation/views/guide_article_detail_view.dart';
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
import 'package:uni/features/search/presentation/views/search_view.dart';
import 'package:uni/features/splash/presentation/views/splash_view.dart';
import 'package:uni/features/uni_detail/presentation/views/uni_detail_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpView());
    case ForgotPasswordView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ForgotPasswordView(),
      );
    case OtpView.routeName:
      final args = settings.arguments as OtpArgs;
      return MaterialPageRoute(builder: (context) => OtpView(args: args));
    case ResetPasswordView.routeName:
      final tempToken = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => ResetPasswordView(tempToken: tempToken),
      );
    case SetupView.routeName:
      return MaterialPageRoute(builder: (context) => const SetupView());
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
    case GuideArticleDetailView.routeName:
      final article = settings.arguments as GuideArticleEntity;
      return MaterialPageRoute(
        builder: (context) => GuideArticleDetailView(article: article),
      );
    case BrowseView.routeName:
      return MaterialPageRoute(builder: (context) => const BrowseView());
    case NotificationsView.routeName:
      return MaterialPageRoute(builder: (context) => const NotificationsView());
    case FaheemChatView.routeName:
      return MaterialPageRoute(builder: (context) => const FaheemChatView());
    case FaheemHistoryView.routeName:
      return MaterialPageRoute(builder: (context) => const FaheemHistoryView());
    case UniDetailView.routeName:
      final id = settings.arguments as int;
      return MaterialPageRoute(builder: (context) => UniDetailView(id: id));
    case SearchView.routeName:
      return MaterialPageRoute(builder: (context) => const SearchView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
