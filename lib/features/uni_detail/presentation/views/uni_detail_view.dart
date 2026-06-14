import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/widgets/ask_faheem_button.dart';
import 'package:uni/features/uni_detail/domain/use_cases/get_uni_detail_use_case.dart';
import 'package:uni/features/uni_detail/presentation/manager/uni_detail_cubit/uni_detail_cubit.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_detail_view_body.dart';

class UniDetailView extends StatelessWidget {
  const UniDetailView({super.key, required this.id});

  static const routeName = 'uni_detail';

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          UniDetailCubit(getIt<GetUniDetailUseCase>())..getUniDetail(id),
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: const Padding(
          padding: EdgeInsets.only(bottom: 70),
          child: AskFaheemButton(),
        ),
        body: SafeArea(child: UniDetailViewBody(id: id)),
      ),
    );
  }
}
