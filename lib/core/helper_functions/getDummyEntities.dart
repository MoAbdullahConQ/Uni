import 'package:flutter/material.dart';
import 'package:uni/core/entities/guide_video_entity.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/features/faheem/domain/entities/chat_history_entity.dart';
import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';
import 'package:uni/features/faheem/domain/entities/suggestion_item_entity.dart';
import 'package:uni/features/guide/domain/entities/guide_article_entity.dart';
import 'package:uni/features/guide/domain/entities/guide_podcast_entity.dart';
import 'package:uni/features/notifications/domain/entities/notification_entity.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_alumni_entity.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_detail_entity.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_faculty_entity.dart';

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
      id: 1,
      name: 'الجامعة البريطانية في مصر',
      location: 'مدينة الشروق',
      imagePath: Assets.imagesUniPic,
      type: 'خاصة',
      rating: 4.8,
      // averageFees: '180k EGP',
      worldRanking: 350,
    ),
    UniEntity(
      id: 2,
      name: 'جامعة عين شمس',
      location: 'العباسية، القاهرة',
      imagePath: Assets.imagesUniPic,
      type: 'حكومية',
      rating: 4.5,
      // averageFees: '25k EGP',
      worldRanking: 300,
    ),
    UniEntity(
      id: 3,
      name: 'جامعة الجلالة',
      location: 'هضبة الجلالة',
      imagePath: Assets.imagesUniPic,
      type: 'معهد عالي',
      rating: 3.1,
      // averageFees: '110k EGP',
      worldRanking: 300,
    ),
    UniEntity(
      id: 4,
      name: 'جامعة عين شمس',
      location: 'العباسية، القاهرة',
      imagePath: Assets.imagesUniPic,
      type: 'حكومية',
      rating: 4.5,
      // averageFees: '25k EGP',
      worldRanking: 300,
    ),
    UniEntity(
      id: 5,
      name: 'جامعة الجلالة',
      location: 'هضبة الجلالة',
      imagePath: Assets.imagesUniPic,
      type: 'معهد عالي',
      rating: 3.1,
      // averageFees: '110k EGP',
      worldRanking: 300,
    ),
  ];
}

// List<NotificationEntity> getDummyTodayNotifications() {
//   return const [
//     NotificationEntity(
//       title: 'تحديث مصاريف الجامعات',
//       body:
//           'تم تحديث قائمة المصاريف للجامعة الألمانية (GUC) للعام الدراسي الجديد. تصفح التحديثات الآن.',
//       timeLabel: 'منذ 10 د',
//       type: NotificationType.update,
//       isRead: false,
//     ),
//     NotificationEntity(
//       title: 'فهيم أفندي 🤖',
//       body:
//           'رديت على استفسارك بخصوص كليات الهندسة المتاحة بمجموع 85%. افتح المحادثة للتفاصيل.',
//       timeLabel: 'منذ ساعتين',
//       type: NotificationType.faheem,
//       isRead: false,
//     ),
//   ];
// }

// List<NotificationEntity> getDummyYesterdayNotifications() {
//   return const [
//     NotificationEntity(
//       title: 'منحة دراسية جديدة',
//       body:
//           'أعلنت جامعة النيل عن منح دراسية تصل إلى 50% لطلاب شعبة علمي رياضة. قدم الآن!',
//       timeLabel: '10:30 ص',
//       type: NotificationType.scholarship,
//       isRead: true,
//     ),
//   ];
// }

// List<NotificationEntity> getDummyThisWeekNotifications() {
//   return const [
//     NotificationEntity(
//       title: 'أهلاً بك في جامعتي 🎓',
//       body:
//           'سعداء بانضمامك لنا! ابدأ بتحديد اهتماماتك لنرشح لك أفضل الجامعات المناسبة لك.',
//       timeLabel: 'الثلاثاء',
//       type: NotificationType.welcome,
//       isRead: true,
//     ),
//     NotificationEntity(
//       title: 'استكمل بياناتك',
//       body:
//           'ملفك الشخصي مكتمل بنسبة 50%. أضف المحافظة الخاصة بك للحصول على نتائج أدق.',
//       timeLabel: 'الإثنين',
//       type: NotificationType.profile,
//       isRead: true,
//     ),
//   ];
// }

List<SuggestionItemEntity> getDummySuggestionItems() {
  return const [
    SuggestionItemEntity(
      icon: Icons.compare_arrows_rounded,
      label: 'مقارنة جامعات',
    ),
    SuggestionItemEntity(
      icon: Icons.build_outlined,
      label: 'أرخص كليات هندسة؟',
    ),
    SuggestionItemEntity(icon: Icons.auto_awesome_rounded, label: 'اكتشف شغفي'),
    SuggestionItemEntity(
      icon: Icons.workspace_premium_outlined,
      label: 'منح المتفوقين',
    ),
  ];
}

List<ChatMessageEntity> getDummyChatMessages() {
  return const [
    ChatMessageEntity(
      text: 'عايزك بناءا علي المجموع بتاعي تقولي انسب الجامعات ليا',
      sender: MessageSender.user,
    ),
    ChatMessageEntity(
      text:
          '👋 أهلاً محمد!\nبناءً على مجموعك 85% واهتمامك بالتكنولوجيا، دي أفضل ترشيحات ليك لكليات الحاسبات والمعلومات:',
      sender: MessageSender.faheem,
    ),
    ChatMessageEntity(
      sender: MessageSender.faheem,
      contentType: MessageContentType.uniCards,
      uniCards: [
        FaheemUniCardEntity(
          name: 'الجامعة المصرية اليابانية',
          location: 'برج العرب',
          imagePath: Assets.imagesUniPic,
          matchPercent: 88,
        ),
        FaheemUniCardEntity(
          name: 'الجامعة المصرية اليابانية',
          location: 'برج العرب',
          imagePath: Assets.imagesUniPic,
          matchPercent: 88,
        ),
        FaheemUniCardEntity(
          name: 'الجامعة المصرية اليابانية',
          location: 'برج العرب',
          imagePath: Assets.imagesUniPic,
          matchPercent: 88,
        ),
      ],
    ),
    ChatMessageEntity(
      text: 'طب إيه أخبار المصاريف في الجامعات دي؟ 🤔',
      sender: MessageSender.user,
    ),
    ChatMessageEntity(sender: MessageSender.faheem, isTyping: true),
  ];
}

List<ChatHistoryEntity> getDummyTodayChats() {
  return const [
    ChatHistoryEntity(
      title: 'أفضل كليات الهندسة الخاصة',
      lastMessage:
          '%, أرشح لك الجامعة البريطانية أو85بناءً على مجموعك الألمانية. ميزانيتك تتوافق تماماً مع متطلباتهم الحالية.',
      timeLabel: '10:30 ص',
      imagePath: Assets.imagesFaheemRobot,
    ),
    ChatHistoryEntity(
      title: 'خطوات التقديم للمنح',
      lastMessage:
          'لتقديم طلب الحصول على منحة تفوق، هتحتاج تجهز شهادة الثانوية العامة، صورة البطاقة، وشهادات إثبات التفوق الرياضي.',
      timeLabel: '08:15 ص',
      imagePath: Assets.imagesFaheemRobot,
    ),
  ];
}

List<ChatHistoryEntity> getDummyThisWeekChats() {
  return const [
    ChatHistoryEntity(
      title: 'الفرق بين حاسبات وذكاء اصطناعي',
      lastMessage:
          'الفرق الأساسي يكمن في التركيز. حاسبات بتركز بشكل عام على هندسة البرمجيات والنظم، بينما الذكاء الاصطناعي يتخصص في',
      timeLabel: 'الإثنين',
      imagePath: Assets.imagesFaheemRobot,
    ),
    ChatHistoryEntity(
      title: '2024مصاريف جامعة الجلالة',
      lastMessage:
          'ألف120مصاريف كلية الطب في جامعة الجلالة للعام الجديد هي جنيه مقسمة على قسطين، ويمكن تقسيطها من خلال بنوك.',
      timeLabel: 'الأحد',
      imagePath: Assets.imagesFaheemRobot,
    ),
  ];
}

UniDetailEntity getDummyUniDetailEntity() {
  return const UniDetailEntity(
    name: 'جامعة المنوفية',
    type: 'حكومية',
    address: 'شارع جمال عبد الناصر، مدينة شبين الكوم، محافظة المنوفية',
    heroImagePath: Assets.imagesUniPic,
    logoImagePath: Assets.imagesZagIcon,
    about:
        'تُعد من الجامعات الإقليمية الكبرى والرائدة في قلب الدلتا، وتلعب دوراً محورياً في البحث العلمي والتطبيقي لخدمة المجتمع المحيط. تتميز الجامعة بقوة كلياتها وتفردها في بعض التخصصات مثل الهندسة الإلكترونية (بمنوف) والزراعة والطب',
    studentsCount: 80000,
    foundedYear: 1976,
    worldRanking: '1201 - 1400',
    uniFacultyEntities: [
      UniFacultyEntity(
        name: 'كلية الهندسة',
        icon: Icons.settings_outlined,
        minFees: '180,000 EGP',
        minGrade: 70,
        requirements: [
          'شهادة الثانوية العامة (شعبة علمي رياضة)',
          'اجتياز اختبار اللغة الإنجليزية (IELTS/TOEFL)',
          'كيلو كباب مشوي (معرفتش اكتب اي هنا)',
        ],
        isExpanded: true,
      ),
      UniFacultyEntity(
        name: 'كلية إدارة الأعمال',
        icon: Icons.work_outline_rounded,
        minFees: '140,000 EGP',
        minGrade: 70,
        requirements: ['شهادة الثانوية العامة', 'اجتياز اختبار القدرات'],
      ),
      UniFacultyEntity(
        name: 'كلية الصيدلة',
        icon: Icons.science_outlined,
        minFees: '165,000 EGP',
        minGrade: 70,
        requirements: ['شهادة الثانوية العامة (شعبة علمي علوم)'],
      ),
      UniFacultyEntity(
        name: 'كلية الحاسبات والمعلومات',
        icon: Icons.computer_outlined,
        minFees: '120,000 EGP',
        minGrade: 65,
        requirements: ['شهادة الثانوية العامة'],
      ),
    ],
    uniAlumniEntities: [
      UniAlumniEntity(
        name: 'د. عادل مبارك',
        description:
            'رئيس جامعة المنوفية الأسبق، وأستاذ علم النفس التربوي، وصاحب إسهامات بارزة في تطوير البنية التحتية والتعليمية للجامعة',
        imagePath: Assets.imagesUniPic,
        graduationYear: 'دفعة 1981',
      ),
      UniAlumniEntity(
        name: 'د. أحمد القاصد',
        description:
            'رئيس جامعة المنوفية الحالي، وأستاذ جراحة الأورام البارز، وقامة طبية وأكاديمية قدمت الكثير للقطاع الطبي بالدلتا',
        imagePath: Assets.imagesUniPic,
        graduationYear: 'دفعة 1987',
      ),
    ],
    campusPhotoPaths: [
      Assets.imagesUniPic,
      Assets.imagesUniPic,
      Assets.imagesUniPic,
      Assets.imagesUniPic,
      Assets.imagesUniPic,
    ],
  );
}

List<UniEntity> getDummySearchResults() {
  return const [
    UniEntity(
      id: 5,
      name: 'الجامعة البريطانية في مصر',
      location: 'مدينة الشروق',
      imagePath: Assets.imagesUniPic,
      // logoPath: Assets.imagesUniLogo,
      type: 'خاصة',
      rating: 4.8,
      // averageFees: '180k EGP',
      worldRanking: 300,
    ),
    UniEntity(
      id: 4,
      name: 'جامعة عين شمس',
      location: 'العباسية، القاهرة',
      imagePath: Assets.imagesUniPic,
      // logoPath: Assets.imagesUniLogo,
      type: 'حكومية',
      rating: 4.5,
      // averageFees: '25k EGP',
      worldRanking: 400,
    ),
    UniEntity(
      id: 1,
      name: 'جامعة الجلالة',
      location: 'هضبة الجلالة',
      imagePath: Assets.imagesUniPic,
      // logoPath: Assets.imagesUniLogo,
      type: 'خاصة',
      rating: 4.2,
      // averageFees: '110k EGP',
      worldRanking: 500,
    ),
  ];
}

List<String> getDummyRecentSearches() {
  return ['هندسة عين شمس', 'مصاريف الجامعة الألمانية', 'طب بشري'];
}

List<String> getDummyTrendingSearches() {
  return [
    'جامعة الجلالة',
    'BUE',
    'منح تفوق',
    'ذكاء اصطناعي',
    'جامعة النيل',
    'فنون جميلة',
  ];
}
