import 'package:uni/core/entities/guide_video_entity.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/features/guide/domain/entities/guide_article_entity.dart';
import 'package:uni/features/guide/domain/entities/guide_podcast_entity.dart';

List<GuideVideoEntity> getDummyGuideVideoEntities() {
  return const [
    GuideVideoEntity(
      title: 'إزاي تختار كليتك بناءً على سوق العمل في 2024؟',
      description: 'دليلك الشامل لمعرفة التخصصات المطلوبة وأفضل الجامعات.',
      thumbnailPath: Assets.imagesVideoThumb,
      duration: '03:42 / 12:45',
      views: 12,
      timeAgo: 'منذ يومين',
    ),
    GuideVideoEntity(
      title: 'إزاي تختار كليتك بناءً على سوق العمل في 2024؟',
      description: 'دليلك الشامل لمعرفة التخصصات المطلوبة وأفضل الجامعات.',
      thumbnailPath: Assets.imagesVideoThumb,
      duration: '03:42 / 12:45',
      views: 12,
      timeAgo: 'منذ يومين',
    ),
    GuideVideoEntity(
      title: 'إزاي تختار كليتك بناءً على سوق العمل في 2024؟',
      description: 'دليلك الشامل لمعرفة التخصصات المطلوبة وأفضل الجامعات.',
      thumbnailPath: Assets.imagesVideoThumb,
      duration: '03:42 / 12:45',
      views: 12,
      timeAgo: 'منذ يومين',
    ),
  ];
}

List<GuidePodcastEntity> getDummyGuidePodcastEntities() {
  return const [
    GuidePodcastEntity(
      title: 'الفرق بين الجامعات الأهلية والخاصة',
      programName: 'برنامج "طريقك للجامعة"',
      thumbnailPath: Assets.imagesVideoThumb,
      duration: '32:15',
    ),
    GuidePodcastEntity(
      title: ': تجربة دراسة الطب12حلقة # البشري، هل تستحق العناء؟',
      programName: 'مع د. أحمد خالد',
      thumbnailPath: Assets.imagesVideoThumb,
      duration: '45:20',
    ),
    GuidePodcastEntity(
      title: 'الفرق بين الجامعات الأهلية والخاصة',
      programName: 'برنامج "طريقك للجامعة"',
      thumbnailPath: Assets.imagesVideoThumb,
      duration: '32:15',
    ),
    GuidePodcastEntity(
      title: ': تجربة دراسة الطب12حلقة # البشري، هل تستحق العناء؟',
      programName: 'مع د. أحمد خالد',
      thumbnailPath: Assets.imagesVideoThumb,
      duration: '45:20',
    ),
  ];
}

List<GuideArticleEntity> getDummyGuideArticleEntities() {
  return const [
    GuideArticleEntity(
      title: 'نصائح ذهبية لاجتياز اختبارات القبول بالجامعات الأهلية',
      category: 'نصائح دراسية',
      readTime: 'قراءة 4 دقائق',
      authorName: 'د. حسام الدين',
      authorRole: 'خبير التوجيه الجامعي',
      publishDate: '12 أكتوبر 2024',
      tags: ['#الجامعات_الأهلية', '#اختبارات_القبول', '#تنسيق_2024'],
    ),
    GuideArticleEntity(
      title: 'الإعلان عن مصروفات الجامعات الخاصة للعام الدراسي الجديد',
      category: 'أخبار الجامعات',
      readTime: 'قراءة 2 دقيقة',
      imagePath: Assets.imagesUniPic,
    ),
  ];
}
