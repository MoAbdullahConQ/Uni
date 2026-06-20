import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/core/widgets/custom_text_form_field.dart';
import 'package:uni/core/widgets/field_label.dart';
import 'package:uni/features/auth/domain/entities/user_entity.dart';
import 'package:uni/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:uni/features/profile/presentation/views/widgets/avatar_profile.dart';
import 'package:uni/features/profile/presentation/views/widgets/documents_section.dart';
import 'package:uni/features/profile/presentation/views/widgets/personal_data_interests_selector.dart';
import 'package:uni/core/widgets/study_type_selector.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:uni/features/profile/presentation/views/widgets/stats_Section.dart';

// maps between the Arabic labels shown in the UI and the values the backend expects.
const Map<String, String> kStudySectionMap = {
  'علمي': 'science',
  'أدبي': 'literature',
};
const Map<String, String> kStudySectionMapReversed = {
  'science': 'علمي',
  'علمي': 'علمي',
  'literature': 'أدبي',
  'أدبي': 'أدبي',
};

const Map<String, String> kScientificDepartmentMap = {
  'علوم': 'scientific',
  'رياضة': 'Mathematics',
};
const Map<String, String> kScientificDepartmentMapReversed = {
  'scientific': 'علوم',
  'علوم': 'علوم',
  'Mathematics': 'رياضة',
  'رياضة': 'رياضة',
};

class PersonalDataViewBody extends StatefulWidget {
  const PersonalDataViewBody({super.key});

  @override
  State<PersonalDataViewBody> createState() => _PersonalDataViewBodyState();
}

class _PersonalDataViewBodyState extends State<PersonalDataViewBody> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  int? selectedGovernorateId;
  final _percentageController = TextEditingController();
  final _ageController = TextEditingController();

  bool _confirmedAccurate = false;

  String studyCategory = 'علمي';
  String studyTrack = 'رياضة';

  bool _populatedFromUser = false;

  // snapshot of the original values loaded from the server — used for no-op guard
  String? _originalStudyCategory;
  String? _originalStudyTrack;
  int? _originalGovernorateId;
  String? _originalPercentage;
  String? _originalAge;

  @override
  void initState() {
    super.initState();
    final state = getIt<ProfileCubit>().state;
    if (state is ProfileSuccess) _populateFromUser(state.user);
  }

  void _populateFromUser(UserEntity user) {
    _nameController.text = user.name;
    _emailController.text = user.email;
    final info = user.studentInfo;
    if (info != null) {
      studyCategory = kStudySectionMapReversed[info.studySection] ?? 'علمي';
      studyTrack =
          kScientificDepartmentMapReversed[info.scientificDepartment] ?? 'علوم';
      selectedGovernorateId = info.governorateId;
      _percentageController.text = info.percentage.toString();
      _ageController.text = info.age.toString();
    }

    // save snapshot for no-op guard
    _originalStudyCategory = studyCategory;
    _originalStudyTrack = studyTrack;
    _originalGovernorateId = selectedGovernorateId;
    _originalPercentage = _percentageController.text;
    _originalAge = _ageController.text;

    _populatedFromUser = true;
  }

  bool _hasChanges() {
    return _originalStudyCategory != studyCategory ||
        _originalStudyTrack != studyTrack ||
        _originalGovernorateId != selectedGovernorateId ||
        _originalPercentage != _percentageController.text ||
        _originalAge != _ageController.text;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _percentageController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_confirmedAccurate) return;

    // no-op guard — skip request if nothing changed
    if (!_hasChanges()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('لم تقم بتغيير أي بيانات')));
      return;
    }

    if (selectedGovernorateId == null) {
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
    if (_formKey.currentState!.validate()) {
      getIt<ProfileCubit>().saveStudentInfo(
        studySection: kStudySectionMap[studyCategory] ?? 'science',
        scientificDepartment: studyCategory == 'علمي'
            ? (kScientificDepartmentMap[studyTrack] ?? 'scientific')
            : null,
        governorateId: selectedGovernorateId!,
        percentage: double.tryParse(_percentageController.text) ?? 0,
        age: age,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      bloc: getIt<ProfileCubit>(),
      listenWhen: (previous, current) =>
          current is StudentInfoSaved ||
          current is SaveStudentInfoFailure ||
          (current is ProfileSuccess && !_populatedFromUser),
      listener: (context, state) {
        if (state is StudentInfoSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم حفظ التعديلات بنجاح'),
              backgroundColor: AppColors.primaryColor,
            ),
          );
        } else if (state is SaveStudentInfoFailure) {
          // if 401, the ApiService interceptor will redirect to LoginView — skip the snackbar
          if (state.errMessage.toLowerCase().contains('unauthenticated'))
            return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: AppColors.subtitleColor,
            ),
          );
        } else if (state is ProfileSuccess && !_populatedFromUser) {
          setState(() => _populateFromUser(state.user));
        }
      },
      builder: (context, state) {
        final isSaving = state is SavingStudentInfo;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            children: [
              const SizedBox(height: kTopPadding),
              ProfileHeader(
                textHeader: 'تعديل البيانات',
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),

                        // ── Avatar ──
                        const AvatarProfile(),
                        const SizedBox(height: 30),

                        // ── Name (read-only — no update-profile endpoint yet) ──
                        const FieldLabel(label: 'الاسم بالكامل'),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          controller: _nameController,
                          enabled: false,
                          hintText: 'مجدي عبدالغني',
                          prefixIcon: Icon(
                            Icons.person_outline,
                            size: 24,
                            color: AppColors.primaryColor.withOpacity(.5),
                          ),
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 16),

                        // ── Email (read-only — no update-profile endpoint yet) ──
                        const FieldLabel(label: 'البريد الإلكتروني'),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          controller: _emailController,
                          enabled: false,
                          hintText: 'ahmed.m@example.com',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            size: 24,
                            color: AppColors.primaryColor.withOpacity(.5),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(height: 16),

                        // ── الشعبة الدراسية ──
                        const FieldLabel(label: 'الشعبة الدراسية'),
                        const SizedBox(height: 6),
                        StudyTypeSelector(
                          options: const ['أدبي', 'علمي'],
                          selected: studyCategory,
                          onSelected: (v) => setState(() => studyCategory = v),
                        ),
                        const SizedBox(height: 16),

                        // ── الشعبة العلمية (visible only when study section is علمي) ──
                        if (studyCategory == 'علمي') ...[
                          const FieldLabel(label: 'الشعبة العلمية'),
                          const SizedBox(height: 6),
                          StudyTypeSelector(
                            options: const ['علوم', 'رياضة'],
                            selected: studyTrack,
                            onSelected: (v) => setState(() => studyTrack = v),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // ── Row: عمر / نسبة / محافظة ──
                        StatsSection(
                          selectedGovernorateId: selectedGovernorateId,
                          onGovernorateChanged: (id) =>
                              setState(() => selectedGovernorateId = id),
                          percentageController: _percentageController,
                          ageController: _ageController,
                        ),
                        const SizedBox(height: 16),

                        // ── مجالات الاهتمام (UI only — no backend endpoint) ──
                        const FieldLabel(label: 'مجالات الاهتمام'),
                        const SizedBox(height: 6),
                        const PersonalDataInterestsSelector(),
                        const SizedBox(height: 24),

                        // ── مستندات مهمة (UI only — no backend endpoint) ──
                        DocumentsSection(
                          confirmedAccurate: _confirmedAccurate,
                          onChanged: (value) {
                            setState(() {
                              _confirmedAccurate = value ?? false;
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // ── حفظ التعديلات ──
                        CustomButton(
                          backgroundColor: _confirmedAccurate
                              ? AppColors.secondaryColor
                              : AppColors.secondaryColor.withOpacity(.4),
                          style: TextStyles.bold16.copyWith(
                            color: AppColors.primaryColor,
                          ),
                          onPressed: (_confirmedAccurate && !isSaving)
                              ? _submit
                              : () {},
                          text: isSaving ? '' : 'حفظ التعديلات',
                          prefixIcon: isSaving
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primaryColor,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
