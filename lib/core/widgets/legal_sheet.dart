import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

// shared bottom sheet for legal content (terms & conditions, privacy policy).
// pass a title and a list of LegalSection items to display.
class LegalSheet extends StatelessWidget {
  const LegalSheet({
    super.key,
    required this.title,
    required this.sections,
  });

  final String title;
  final List<LegalSection> sections;

  static void show(
    BuildContext context, {
    required String title,
    required List<LegalSection> sections,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LegalSheet(title: title, sections: sections),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              // drag handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 16),
              Text(title, style: TextStyles.bold18),
              const SizedBox(height: 16),
              const Divider(height: 1, color: AppColors.borderColor),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: sections
                        .map((s) => _LegalSectionItem(section: s))
                        .toList(),
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

// data class representing one section in a legal document
class LegalSection {
  const LegalSection({required this.title, required this.body});

  final String title;
  final String body;
}

class _LegalSectionItem extends StatelessWidget {
  const _LegalSectionItem({required this.section});

  final LegalSection section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: TextStyles.bold14.copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 6),
          Text(
            section.body,
            style: TextStyles.regular14.copyWith(
              color: AppColors.subtitleColor,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

