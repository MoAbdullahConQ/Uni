import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/widgets/custom_error_widget.dart';
import 'package:uni/features/uni_detail/presentation/manager/uni_detail_cubit/uni_detail_cubit.dart';
import 'package:uni/features/uni_detail/presentation/manager/uni_detail_cubit/uni_detail_state.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_detail_content.dart';

class UniDetailViewBody extends StatefulWidget {
  const UniDetailViewBody({super.key});

  @override
  State<UniDetailViewBody> createState() => _UniDetailViewBodyState();
}

class _UniDetailViewBodyState extends State<UniDetailViewBody>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UniDetailCubit, UniDetailState>(
      builder: (context, state) {
        if (state is UniDetailLoading || state is UniDetailInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is UniDetailFailure) {
          return CustomErrorWidget(message: state.errMessage);
        }
        if (state is UniDetailSuccess) {
          return UniDetailContent(
            uniDetailEntity: state.uniDetailEntity,
            tabController: tabController,
          );
        }
        return const SizedBox();
      },
    );
  }
}
