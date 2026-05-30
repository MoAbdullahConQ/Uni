import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/widgets/ask_faheem_button.dart';
import 'package:uni/features/browse/domain/use_cases/get_unis_use_case.dart';
import 'package:uni/features/browse/presentation/manager/browse_cubit/browse_cubit.dart';
import 'package:uni/features/browse/presentation/views/widgets/browse_view_body.dart';
import 'package:uni/features/fav/domain/use_cases/add_to_fav_use_case.dart';
import 'package:uni/features/fav/domain/use_cases/get_favs_use_case.dart';
import 'package:uni/features/fav/domain/use_cases/remove_from_fav_use_case.dart';
import 'package:uni/features/fav/presentation/manager/fav_cubit/fav_cubit.dart';

class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

  static const String routeName = 'browse';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BrowseCubit(getIt<GetUnisUseCase>())..getUnis(),
        ),
        BlocProvider(
          create: (context) => FavCubit(
            getFavsUseCase: getIt<GetFavsUseCase>(),
            addToFavUseCase: getIt<AddToFavUseCase>(),
            removeFromFavUseCase: getIt<RemoveFromFavUseCase>(),
          )..getFavs(),
        ),
      ],
      child: const Scaffold(
        floatingActionButton: AskFaheemButton(),
        backgroundColor: Colors.white,
        body: SafeArea(child: BrowseViewBody()),
      ),
    );
  }
}
