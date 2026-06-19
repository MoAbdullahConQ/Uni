import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/cubits/trending_cubit/trending_cubit.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/widgets/ask_faheem_button.dart';
import 'package:uni/features/fav/presentation/manager/fav_cubit/fav_cubit.dart';
import 'package:uni/features/fav/presentation/views/widgets/fav_view_body.dart';
import 'package:uni/features/guide/presentation/manager/guide_cubit/guide_cubit.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_view_body.dart';
import 'package:uni/features/home/data/data_sources/recommended_remote_data_source.dart';
import 'package:uni/features/home/presentation/manager/recommended_cubit/recommended_cubit.dart';
import 'package:uni/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:uni/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:uni/features/notifications/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:uni/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:uni/main.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  static const String routeName = 'MainView';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with RouteAware {
  int currentIndex = 0;
  late final List<Widget> views;
  late final RecommendedCubit _recommendedCubit;

  @override
  void initState() {
    super.initState();
    views = [
      const HomeViewBody(),
      const GuideViewBody(),
      const FavViewBody(),
      const ProfileViewBody(),
    ];

    _recommendedCubit = RecommendedCubit(getIt<RecommendedRemoteDataSource>())
      ..fetchRecommendedUnis();

    getIt<TrendingCubit>().fetchTrendingUnis();
    getIt<FavCubit>().getFavs();
    getIt<GuideCubit>().getArticles();
    getIt<NotificationsCubit>().getNotifications();
    // load profile once on app start so Home AppBar shows name/avatar
    // immediately without requiring a visit to the profile screen first
    getIt<ProfileCubit>().getMe();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _recommendedCubit.close();
    super.dispose();
  }

  @override
  void didPopNext() {
    getIt<NotificationsCubit>().getNotifications();

    // reload only if they were in failure state
    if (getIt<TrendingCubit>().state is TrendingFailure) {
      getIt<TrendingCubit>().fetchTrendingUnis();
    }
    if (getIt<FavCubit>().state is FavFailure) {
      getIt<FavCubit>().getFavs();
    }
    if (getIt<GuideCubit>().state is GuideFailure) {
      getIt<GuideCubit>().getArticles();
    }
    if (_recommendedCubit.state is RecommendedFailure) {
      _recommendedCubit.fetchRecommendedUnis();
    }
  }

  void _onTabChanged(int index) {
    if (index == 0 && currentIndex != 0) {
      // always refresh notifications when returning to home
      getIt<NotificationsCubit>().getNotifications();

      // reload only if they were in failure state
      if (getIt<TrendingCubit>().state is TrendingFailure) {
        getIt<TrendingCubit>().fetchTrendingUnis();
      }
      if (_recommendedCubit.state is RecommendedFailure) {
        _recommendedCubit.fetchRecommendedUnis();
      }
    }
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<TrendingCubit>()),
        BlocProvider.value(value: getIt<GuideCubit>()),
        BlocProvider.value(value: _recommendedCubit),
      ],
      child: Scaffold(
        floatingActionButton: currentIndex != 3
            ? const AskFaheemButton()
            : null,
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: currentIndex,
          onIndexChanged: _onTabChanged,
        ),
        body: SafeArea(child: views[currentIndex]),
      ),
    );
  }
}
