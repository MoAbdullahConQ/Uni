import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uni/features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/login_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/register_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/save_student_info_use_case.dart';
import 'package:uni/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:uni/features/auth/presentation/views/widgets/setup_view_body.dart';

class SetupView extends StatelessWidget {
  static const String routeName = 'setup';

  const SetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(
        loginUseCase: GetIt.instance<LoginUseCase>(),
        registerUseCase: GetIt.instance<RegisterUseCase>(),
        forgetPasswordUseCase: GetIt.instance<ForgetPasswordUseCase>(),
        resetPasswordUseCase: GetIt.instance<ResetPasswordUseCase>(),
        saveStudentInfoUseCase: GetIt.instance<SaveStudentInfoUseCase>(),
      ),
      child: const Scaffold(body: SafeArea(child: SetupViewBody())),
    );
  }
}
