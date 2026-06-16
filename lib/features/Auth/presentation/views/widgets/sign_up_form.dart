import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/core/widgets/custom_text_form_field.dart';
import 'package:uni/core/widgets/password_field.dart';
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // name field
          Text(
            'الاسم بالكامل',
            style: TextStyles.semiBold14.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
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
          Text(
            'البريد الإلكتروني',
            style: TextStyles.semiBold14.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
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
          Text(
            'كلمة المرور',
            style: TextStyles.semiBold14.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
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
          ),
          const SizedBox(height: 16),

          // confirm password field
          Text(
            'تأكيد كلمة المرور',
            style: TextStyles.semiBold14.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
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
            validator: (value) {
              if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
              if (value != _passwordController.text) {
                return 'كلمة المرور غير متطابقة';
              }
              return null;
            },
          ),

          // Terms and Conditions checkbox
          TermsAndConditions(
            value: _agreedToTerms,
            onChanged: (value) =>
                setState(() => _agreedToTerms = value ?? false),
          ),
          const SizedBox(height: 16),

          // submit button
          CustomButton(
            onPressed: () {
              if (!_agreedToTerms) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('يجب الموافقة على الشروط والأحكام'),
                  ),
                );
                return;
              }
              if (_formKey.currentState!.validate()) {
                widget.onEmailChanged(_emailController.text.trim());

                _nameController.text.trim();
                _emailController.text.trim();
                _passwordController.text;
                _confirmPasswordController.text;
              }
            },
            text: 'إنشاء الحساب',
            backgroundColor: AppColors.secondaryColor,
            style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
