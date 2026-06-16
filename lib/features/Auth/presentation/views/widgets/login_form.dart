import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/core/widgets/custom_text_form_field.dart';
import 'package:uni/core/widgets/password_field.dart';
import 'package:uni/features/auth/presentation/views/login_view.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // email field
          Text(
            'البريد الإلكتروني أو الهاتف',
            style: TextStyles.semiBold14.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 24),

          // password field
          Text(
            'كلمة المرور',
            style: TextStyles.semiBold14.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),

          // forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                onTap: () => Navigator.pushNamed(context, LoginView.routeName),
                child: Text(
                  'نسيت كلمة المرور؟',
                  style: TextStyles.regular14.copyWith(
                    color: AppColors.primaryColor.withOpacity(.7),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 24),
          // submit button
          CustomButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _emailController.text.trim();
                _passwordController.text;
              }
            },
            text: 'تسجيل الدخول',
            backgroundColor: AppColors.secondaryColor,
            style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
