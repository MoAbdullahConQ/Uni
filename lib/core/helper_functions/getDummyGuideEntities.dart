import 'package:uni/core/entities/guide_video_entity.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/features/guide/domain/entities/guide_article_entity.dart';
import 'package:uni/features/guide/domain/entities/guide_podcast_entity.dart';
import 'package:uni/features/notifications/domain/entities/notification_entity.dart';

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

List<UniEntity> getDummyUniEntities() {
  return const [
    UniEntity(
      name: 'الجامعة البريطانية في مصر',
      location: 'مدينة الشروق',
      imagePath: Assets.imagesUniPic,
      type: 'خاصة',
      rating: 4.8,
      averageFees: '180k EGP',
    ),
    UniEntity(
      name: 'جامعة عين شمس',
      location: 'العباسية، القاهرة',
      imagePath: Assets.imagesUniPic,
      type: 'حكومية',
      rating: 4.5,
      averageFees: '25k EGP',
    ),
    UniEntity(
      name: 'جامعة الجلالة',
      location: 'هضبة الجلالة',
      imagePath: Assets.imagesUniPic,
      type: 'معهد عالي',
      rating: 3.1,
      averageFees: '110k EGP',
    ),
    UniEntity(
      name: 'جامعة عين شمس',
      location: 'العباسية، القاهرة',
      imagePath: Assets.imagesUniPic,
      type: 'حكومية',
      rating: 4.5,
      averageFees: '25k EGP',
    ),
    UniEntity(
      name: 'جامعة الجلالة',
      location: 'هضبة الجلالة',
      imagePath: Assets.imagesUniPic,
      type: 'معهد عالي',
      rating: 3.1,
      averageFees: '110k EGP',
    ),
  ];
}

List<NotificationEntity> getDummyTodayNotifications() {
  return const [
    NotificationEntity(
      title: 'تحديث مصاريف الجامعات',
      body: 'تم تحديث قائمة المصاريف للجامعة الألمانية (GUC) للعام الدراسي الجديد. تصفح التحديثات الآن.',
      timeLabel: 'منذ 10 د',
      type: NotificationType.update,
      isRead: false,
    ),
    NotificationEntity(
      title: 'فهيم أفندي 🤖',
      body: 'رديت على استفسارك بخصوص كليات الهندسة المتاحة بمجموع 85%. افتح المحادثة للتفاصيل.',
      timeLabel: 'منذ ساعتين',
      type: NotificationType.faheem,
      isRead: false,
    ),
  ];
}

List<NotificationEntity> getDummyYesterdayNotifications() {
  return const [
    NotificationEntity(
      title: 'منحة دراسية جديدة',
      body: 'أعلنت جامعة النيل عن منح دراسية تصل إلى 50% لطلاب شعبة علمي رياضة. قدم الآن!',
      timeLabel: '10:30 ص',
      type: NotificationType.scholarship,
      isRead: true,
    ),
  ];
}

List<NotificationEntity> getDummyThisWeekNotifications() {
  return const [
    NotificationEntity(
      title: 'أهلاً بك في جامعتي 🎓',
      body: 'سعداء بانضمامك لنا! ابدأ بتحديد اهتماماتك لنرشح لك أفضل الجامعات المناسبة لك.',
      timeLabel: 'الثلاثاء',
      type: NotificationType.welcome,
      isRead: true,
    ),
    NotificationEntity(
      title: 'استكمل بياناتك',
      body: 'ملفك الشخصي مكتمل بنسبة 50%. أضف المحافظة الخاصة بك للحصول على نتائج أدق.',
      timeLabel: 'الإثنين',
      type: NotificationType.profile,
      isRead: true,
    ),
  ];
}
