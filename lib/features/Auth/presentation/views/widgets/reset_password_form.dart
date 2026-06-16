import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/helper_functions/calc_strength.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/core/widgets/password_field.dart';
import 'package:uni/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:uni/core/widgets/field_label.dart';
import 'package:uni/core/widgets/security_strength_indicator.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key, required this.tempToken});

  final String tempToken;

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  double _strength = 0;
  bool? _passwordsMatch;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().resetPassword(
            password: _passwordController.text,
            passwordConfirmation: _confirmController.text,
            tempToken: widget.tempToken,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // new password field
          const FieldLabel(label: 'كلمة المرور الجديدة'),
          const SizedBox(height: 8),
          PasswordField(
            controller: _passwordController,
            hintText: '••••••••',
            keyboardType: TextInputType.visiblePassword,
            textAlign: TextAlign.right,
            prefixIcon: Icon(
              Icons.lock_outline,
              size: 20,
              color: AppColors.primaryColor.withOpacity(.6),
            ),
            onChanged: (value) {
              setState(() => _strength = calcStrength(value));
            },
            validator: (value) {
              if (value == null || value.length < 8) {
                return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),

          // strength indicator
          SecurityStrengthIndicator(strength: _strength),
          const SizedBox(height: 24),

          // confirm password field
          const FieldLabel(label: 'تأكيد كلمة المرور'),
          const SizedBox(height: 8),
          PasswordField(
            controller: _confirmController,
            hintText: '••••••••',
            keyboardType: TextInputType.visiblePassword,
            textAlign: TextAlign.right,
            prefixIcon: Icon(
              Icons.lock_outline,
              size: 20,
              color: AppColors.primaryColor.withOpacity(.6),
            ),
            onChanged: (value) {
              setState(() {
                _passwordsMatch = value.isEmpty
                    ? null
                    : value == _passwordController.text;
              });
            },
            borderColor: _passwordsMatch == null
                ? null
                : _passwordsMatch!
                    ? AppColors.secondaryColor
                    : AppColors.red,
            validator: (value) {
              if (value != _passwordController.text) {
                return 'كلمتا المرور غير متطابقتين';
              }
              return null;
            },
          ),
          if (_passwordsMatch != null) ...[
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                _passwordsMatch!
                    ? 'كلمتا المرور متطابقتان ✓'
                    : 'كلمتا المرور غير متطابقتين',
                style: TextStyles.regular12.copyWith(
                  color: _passwordsMatch!
                      ? const Color(0xFF6BBF26)
                      : AppColors.red,
                ),
              ),
            ),
          ],
          const SizedBox(height: 32),

          // submit button
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return CustomButton(
                onPressed: state is AuthLoading ? () {} : _submit,
                text: state is AuthLoading ? '' : 'تغيير كلمة المرور',
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
