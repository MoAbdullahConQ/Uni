import 'package:flutter/material.dart';
import 'package:uni/features/search/presentation/views/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  static const routeName = 'search';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF4FAE8),
      body: SafeArea(child: SearchViewBody()),
    );
  }
}
