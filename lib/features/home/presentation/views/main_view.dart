import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/cubits/trending_cubit/trending_cubit.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/widgets/ask_faheem_button.dart';
import 'package:uni/features/fav/presentation/manager/fav_cubit/fav_cubit.dart';
import 'package:uni/features/fav/presentation/views/widgets/fav_view_body.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_view_body.dart';
import 'package:uni/features/home/data/data_sources/recommended_remote_data_source.dart';
import 'package:uni/features/home/presentation/manager/recommended_cubit/recommended_cubit.dart';
import 'package:uni/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:uni/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_view_body.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  static const String routeName = 'MainView';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;
  late final List<Widget> views;

  @override
  void initState() {
    super.initState();
    views = [
      const HomeViewBody(),
      const GuideViewBody(),
      const FavViewBody(),
      const ProfileViewBody(),
    ];
    getIt<TrendingCubit>().fetchTrendingUnis();
    getIt<FavCubit>().getFavs();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<TrendingCubit>()),
        BlocProvider(
          create: (_) =>
              RecommendedCubit(getIt<RecommendedRemoteDataSource>())
                ..fetchRecommendedUnis(),
        ),
      ],
      child: Scaffold(
        floatingActionButton: currentIndex != 3
            ? const AskFaheemButton()
            : null,
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: currentIndex,
          onIndexChanged: (int index) {
            setState(() => currentIndex = index);
          },
        ),
        body: SafeArea(child: views[currentIndex]),
      ),
    );
  }
}
