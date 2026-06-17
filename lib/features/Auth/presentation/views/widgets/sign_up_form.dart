import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/helper_functions/calc_strength.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/core/widgets/custom_text_form_field.dart';
import 'package:uni/core/widgets/field_label.dart';
import 'package:uni/core/widgets/password_field.dart';
import 'package:uni/core/widgets/security_strength_indicator.dart';
import 'package:uni/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:uni/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key, required this.onEmailChanged});

  // callback to pass email up to SignUpViewBody for OTP navigation
  final ValueChanged<String> onEmailChanged;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;

  double _strength = 0;
  bool? _passwordsMatch;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب الموافقة على الشروط والأحكام')),
      );
      return;
    }
    // block submission if passwords don't match — independent of validator
    if (_passwordController.text != _confirmPasswordController.text) return;
    if (_formKey.currentState!.validate()) {
      widget.onEmailChanged(_emailController.text.trim());
      context.read<AuthCubit>().register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        passwordConfirmation: _confirmPasswordController.text,
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
          // name field
          const FieldLabel(label: 'الاسم بالكامل'),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: _nameController,
            hintText: 'محمد أحمد',
            keyboardType: TextInputType.name,
            textAlign: TextAlign.right,
            prefixIcon: Icon(
              Icons.person_outline,
              size: 20,
              color: AppColors.primaryColor.withOpacity(.6),
            ),
          ),
          const SizedBox(height: 16),

          // email field
          const FieldLabel(label: 'البريد الإلكتروني'),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: _emailController,
            hintText: 'name@example.com',
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.right,
            prefixIcon: Icon(
              Icons.email_outlined,
              size: 20,
              color: AppColors.primaryColor.withOpacity(.6),
            ),
          ),
          const SizedBox(height: 16),

          // password field
          const FieldLabel(label: 'كلمة المرور'),
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
              setState(() {
                _strength = calcStrength(value);
                // re-validate match against the (possibly already filled) confirm field
                _passwordsMatch = _confirmPasswordController.text.isEmpty
                    ? null
                    : value == _confirmPasswordController.text;
              });
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

          const SizedBox(height: 16),

          // confirm password field
          const FieldLabel(label: 'تأكيد كلمة المرور'),
          const SizedBox(height: 8),
          PasswordField(
            controller: _confirmPasswordController,
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
            // validator only checks required — match is enforced in _submit()
            validator: (value) {
              if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
              return null;
            },
          ),
          if (_passwordsMatch != null) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(right: 6),
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

          // Terms and Conditions checkbox
          TermsAndConditions(
            value: _agreedToTerms,
            onChanged: (value) =>
                setState(() => _agreedToTerms = value ?? false),
          ),
          const SizedBox(height: 16),

          // submit button
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return CustomButton(
                onPressed: state is AuthLoading ? () {} : _submit,
                text: state is AuthLoading ? '' : 'إنشاء الحساب',
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
                backgroundColor: AppColors.secondaryColor,
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
