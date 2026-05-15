import 'package:flutter/material.dart';
import 'package:uni/features/on_boarding/presentation/on_boarding_data.dart';
import 'package:uni/features/on_boarding/presentation/views/widgets/on_boarding_bottom_bar.dart';
import 'package:uni/features/on_boarding/presentation/views/widgets/on_boarding_page_item.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key, required this.onDone});
  final VoidCallback onDone;

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  var currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    // pageController.addListener(() {
    //   currentPage = pageController.page!.round();
    //   setState(() {});
    // });
  }

  void _nextPage() {
    if (currentPage < kOnBoardingPages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onDone();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: kOnBoardingPages.length,
            onPageChanged: (i) => setState(() => currentPage = i),
            itemBuilder: (context, index) =>
                OnBoardingPageItem(data: kOnBoardingPages[index]),
          ),
        ),
        OnBoardingBottomBar(
          currentPage: currentPage,
          pagesCount: kOnBoardingPages.length,
          onNext: _nextPage,
          onSkip: widget.onDone,
        ),
      ],
    );
  }
}
