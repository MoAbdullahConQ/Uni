import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/login_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/register_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/save_student_info_use_case.dart';
import 'package:uni/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:uni/features/auth/presentation/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const String routeName = 'login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        loginUseCase: getIt<LoginUseCase>(),
        registerUseCase: getIt<RegisterUseCase>(),
        forgetPasswordUseCase: getIt<ForgetPasswordUseCase>(),
        resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
        saveStudentInfoUseCase: getIt<SaveStudentInfoUseCase>(),
      ),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: LoginViewBody()),
      ),
    );
  }
}
