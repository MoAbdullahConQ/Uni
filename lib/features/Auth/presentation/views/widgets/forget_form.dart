import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/core/widgets/custom_text_form_field.dart';
import 'package:uni/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';

class ForgetForm extends StatefulWidget {
  const ForgetForm({super.key, required this.emailController});

  final TextEditingController emailController;

  @override
  State<ForgetForm> createState() => _ForgetFormState();
}

class _ForgetFormState extends State<ForgetForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().forgetPassword(
        email: widget.emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'البريد الإلكتروني',
            style: TextStyles.semiBold14.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: widget.emailController, // ✅
            hintText: 'name@example.com',
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.right,
            prefixIcon: Icon(
              Icons.email_outlined,
              size: 20,
              color: AppColors.primaryColor.withOpacity(.6),
            ),
          ),
          const SizedBox(height: 24),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return CustomButton(
                onPressed: state is AuthLoading ? () {} : _submit,
                text: state is AuthLoading ? '' : 'إرسال الرمز',
                backgroundColor: AppColors.secondaryColor,
                prefixIcon: state is AuthLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primaryColor,
                        ),
                      )
                    : null,
                style: TextStyles.bold16.copyWith(
                  color: AppColors.primaryColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
