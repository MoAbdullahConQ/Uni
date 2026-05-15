import 'package:uni/core/utils/app_images.dart';

class OnBoardingData {
  final String tag;
  final String title;
  final String titleHighlight;
  final String body;
  final String image;

  const OnBoardingData({
    required this.image,
    required this.tag,
    required this.title,
    required this.titleHighlight,
    required this.body,
  });
}

const List<OnBoardingData> kOnBoardingPages = [
  OnBoardingData(
    image: Assets.imagesPageViewItem1Image,
    tag: 'الأول في   🇪🇬',
    title: 'كل جامعات مصر',
    titleHighlight: 'في جيبك',
    body:
        'قارن بين المصاريف، المواقع، والتصنيفات العالمية لكل الجامعات بسهولة وذكاء مع مساعدك الشخصي.',
  ),
  OnBoardingData(
    image: Assets.imagesPageViewItem2Image,
    tag: 'أداء AI في خدمتك  🤖',
    title: 'أختيار اسهل مع',
    titleHighlight: 'فهيم',
    body:
        'دردش مع فهيم عن مهاراتك وقدراتك ومواهبك وهيساعدك تصل للتخصص المناسب ليك.',
  ),
  OnBoardingData(
    image: Assets.imagesPageViewItem3Image,
    tag: 'مقارنة اسهل  ⚖️',
    title: 'تقديم اسهل علي',
    titleHighlight: 'الجامعات',
    body: 'اختار الجامعة اللي مناسبة ليك وهقدم من خلالنا وهنوفر عليك المشاوير.',
  ),
];
