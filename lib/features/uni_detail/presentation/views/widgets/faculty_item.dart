import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_faculty_entity.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/faculty_item_expanded_content.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/faculty_item_header.dart';

class FacultyItem extends StatefulWidget {
  const FacultyItem({super.key, required this.uniFacultyEntity});

  final UniFacultyEntity uniFacultyEntity;

  @override
  State<FacultyItem> createState() => _FacultyItemState();
}

class _FacultyItemState extends State<FacultyItem> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = false;
  }

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isExpanded ? AppColors.lightSecondaryColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpanded
              ? AppColors.secondaryColor.withOpacity(0.8)
              : AppColors.borderColor,
          width: 1.2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19AFEB6F),
            offset: Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          FacultyItemHeader(
            uniFacultyEntity: widget.uniFacultyEntity,
            isExpanded: isExpanded,
            onTap: toggleExpanded,
          ),

          if (isExpanded) ...[
            Divider(height: 1, color: AppColors.secondaryColor.withOpacity(.8)),

            FacultyItemExpandedContent(
              uniFacultyEntity: widget.uniFacultyEntity,
            ),
          ],

          // Expanded content
        ],
      ),
    );
  }
}
