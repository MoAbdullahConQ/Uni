import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/features/fav/domain/use_cases/add_to_fav_use_case.dart';
import 'package:uni/features/fav/domain/use_cases/get_favs_use_case.dart';
import 'package:uni/features/fav/domain/use_cases/remove_from_fav_use_case.dart';
import 'package:uni/features/fav/presentation/manager/fav_cubit/fav_cubit.dart';
import 'package:uni/features/fav/presentation/views/widgets/fav_view_body.dart';

class FavView extends StatelessWidget {
  const FavView({super.key});

  static const String routeName = 'fav_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavCubit(
        getFavsUseCase: getIt<GetFavsUseCase>(),
        addToFavUseCase: getIt<AddToFavUseCase>(),
        removeFromFavUseCase: getIt<RemoveFromFavUseCase>(),
      )..getFavs(),
      child: const Scaffold(body: SafeArea(child: FavViewBody())),
    );
  }
}
