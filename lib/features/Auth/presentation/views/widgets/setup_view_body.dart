import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/widgets/field_label.dart';
import 'package:uni/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:uni/core/widgets/study_type_selector.dart';
import 'package:uni/features/auth/presentation/views/widgets/setup_governorate_dropdown.dart';

class SetupViewBody extends StatefulWidget {
  const SetupViewBody({super.key});

  @override
  State<SetupViewBody> createState() => _SetupViewBodyState();
}

class _SetupViewBodyState extends State<SetupViewBody> {
  // علمي → 'science' | أدبي → 'literature'
  String _studySection = 'علمي';

  int? _governorateId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
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

            // المحافظة
            const FieldLabel(label: 'المحافظة'),
            const SizedBox(height: 8),
            SetupGovernorateDropdown(
              selectedId: _governorateId,
              onChanged: (id) => setState(() => _governorateId = id),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
