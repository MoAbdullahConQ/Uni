import 'package:uni/core/entities/guide_video_entity.dart';
import 'package:uni/core/utils/app_images.dart';

GuideVideoEntity getDummyGuideVideoEntity() {
  return const GuideVideoEntity(
    title: 'إزاي تختار كليتك بناءً على سوق العمل في 2024؟',
    description: 'دليلك الشامل لمعرفة التخصصات المطلوبة وأفضل الجامعات.',
    thumbnailPath: Assets.imagesVideoThumb,
    duration: '03:42 / 12:45',
    views: 12,
    timeAgo: 'منذ يومين',
  );
}

List<GuideVideoEntity> getDummyGuideVideoEntities() {
  return [
    getDummyGuideVideoEntity(),
    getDummyGuideVideoEntity(),
    getDummyGuideVideoEntity(),
    getDummyGuideVideoEntity(),
  ];
}
