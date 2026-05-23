import 'package:flutter/material.dart';
import 'package:uni/features/search/presentation/views/widgets/HeaderSearchFilterBottomSheet.dart';

class SearchFilterBottomSheet extends StatelessWidget {
  const SearchFilterBottomSheet({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          HeaderSearchFilterBottomSheet(resetOnTap: () {}),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
