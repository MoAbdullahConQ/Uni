import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/profile/presentation/views/widgets/message_form_section.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:uni/features/profile/presentation/views/widgets/quick_contact.dart';
import 'package:uni/features/profile/presentation/views/widgets/robot_section.dart';

class ContactUsViewBody extends StatefulWidget {
  const ContactUsViewBody({super.key});

  @override
  State<ContactUsViewBody> createState() => _ContactUsViewBodyState();
}

class _ContactUsViewBodyState extends State<ContactUsViewBody> {
  final _formKey = GlobalKey<FormState>();

  final List<String> topics = [
    'مشكلة تقنية',
    'استفسار عام',
    'شكوى',
    'اقتراح',
    'أخرى',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        children: [
          const SizedBox(height: kTopPadding),
          ProfileHeader(
            textHeader: 'تواصل معنا',
            textStyle: TextStyles.regular20.copyWith(
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: AppColors.borderColor),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 32),

                  // ── Robot illustration placeholder ──
                  const RobotSection(),
                  const SizedBox(height: 24),

                  // ── Quick contact──
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'تواصل سريع',
                      style: TextStyles.bold13.copyWith(
                        color: AppColors.subtitleColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const QuickContact(),
                  const SizedBox(height: 16),

                  // ── Divider ──
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'أو اترك رسالة',
                          style: TextStyles.semiBold13.copyWith(
                            color: AppColors.subtitleColor.withOpacity(.6),
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ── Message form ──
                  MessageFormSection(formKey: _formKey, topics: topics),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
