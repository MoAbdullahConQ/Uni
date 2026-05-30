import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/widgets/ask_faheem_button.dart';
import 'package:uni/features/search/domain/use_cases/search_unis_use_case.dart';
import 'package:uni/features/search/presentation/manager/search_cubit/search_cubit.dart';
import 'package:uni/features/search/presentation/views/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  static const routeName = 'search';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(getIt<SearchUnisUseCase>()),
      child: const Scaffold(
        backgroundColor: Color(0xFFF4FAE8),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 40),
          child: AskFaheemButton(),
        ),
        body: SafeArea(child: SearchViewBody()),
      ),
    );
  }
}
