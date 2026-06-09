import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/features/guide/presentation/manager/guide_cubit/guide_cubit.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_articles_view_body.dart';

class GuideArticlesView extends StatelessWidget {
  const GuideArticlesView({super.key});

  static const String routeName = 'guide_article_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<GuideCubit>()..getArticles(),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: GuideArticlesViewBody()),
      ),
    );
  }
}
