import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/core/widgets/field_label.dart';
import 'package:uni/core/widgets/percentage_field.dart';
import 'package:uni/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:uni/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:uni/core/widgets/study_type_selector.dart';
import 'package:uni/core/widgets/age_field.dart';
import 'package:uni/features/auth/presentation/views/widgets/setup_governorate_dropdown.dart';
import 'package:uni/features/home/presentation/views/main_view.dart';
import 'package:uni/features/profile/presentation/views/widgets/personal_data_interests_selector.dart';

class SetupViewBody extends StatefulWidget {
  const SetupViewBody({super.key});

  @override
  State<SetupViewBody> createState() => _SetupViewBodyState();
}

class _SetupViewBodyState extends State<SetupViewBody> {
  // علمي → 'science' | أدبي → 'literature'
  String _studySection = 'علمي';
  // علوم → 'scientific' | رياضة → 'Mathematics'
  String _scientificDepartment = 'علوم';

  int? _governorateId;

  final _formKey = GlobalKey<FormState>();
  final _percentageController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _percentageController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  String _studySectionApiValue() =>
      _studySection == 'علمي' ? 'science' : 'literature';

  String _scientificDepartmentApiValue() =>
      _scientificDepartment == 'علوم' ? 'scientific' : 'Mathematics';

  void _submit() {
    if (_governorateId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('من فضلك اختر المحافظة')));
      return;
    }
    final percentage = double.tryParse(_percentageController.text);
    if (percentage == null || percentage < 50 || percentage > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('من فضلك اختر درجة مناسبة (من 50 إلى 100)'),
        ),
      );
      return;
    }
    final age = int.tryParse(_ageController.text);
    if (age == null || age < 14 || age > 30) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك اختر عمر مناسب (من 14 إلى 30)')),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().saveStudentInfo(
      studySection: _studySectionApiValue(),
      scientificDepartment: _studySection == 'علمي'
          ? _scientificDepartmentApiValue()
          : null,
      governorateId: _governorateId!,
      percentage: double.parse(_percentageController.text),
      age: int.parse(_ageController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إنشاء حسابك بنجاح ✓'),
              backgroundColor: AppColors.lightPrimaryColor,
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainView.routeName,
            (route) => false,
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kTopPadding,
        ),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                // header
                const AuthHeader(
                  title: 'جهز ملفك الشخصي🎓',
                  subtitle: 'ساعدنا نخصص تجربتك بناءً على اهتماماتك',
                ),
                const SizedBox(height: 32),

                // الشعبة الدراسية
                const FieldLabel(label: 'الشعبة الدراسية'),
                const SizedBox(height: 8),
                StudyTypeSelector(
                  options: const ['أدبي', 'علمي'],
                  selected: _studySection,
                  onSelected: (v) => setState(() => _studySection = v),
                  icons: const {
                    'أدبي': Icons.menu_book_outlined,
                    'علمي': Icons.science_outlined,
                  },
                ),
                const SizedBox(height: 24),

                // Governorate
                const FieldLabel(label: 'المحافظة'),
                const SizedBox(height: 8),
                SetupGovernorateDropdown(
                  selectedId: _governorateId,
                  onChanged: (id) => setState(() => _governorateId = id),
                ),
                const SizedBox(height: 24),

                Row(
                  children: [
                    // percentage
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const FieldLabel(label: 'النسبة المئوية'),
                          const SizedBox(height: 8),
                          PercentageField(controller: _percentageController),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // age
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const FieldLabel(label: 'السن'),
                          const SizedBox(height: 8),
                          AgeField(controller: _ageController),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // مجالات الاهتمام — UI only, no backend endpoint yet
                Row(
                  children: [
                    const FieldLabel(label: 'مجالات الاهتمام'),
                    const SizedBox(width: 8),
                    Text(
                      '(اختر 3 على الأقل)',
                      style: TextStyles.regular12.copyWith(
                        color: AppColors.subtitleColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const PersonalDataInterestsSelector(),
                const SizedBox(height: 32),

                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: state is AuthLoading ? () {} : _submit,
                      text: state is AuthLoading ? '' : 'إنهاء',
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
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
