const kHorizontalPadding = 16.0;

const kTopPadding = 16.0;

const kIsOnBoardingViewSeenKey = 'isOnBoardingViewSeen';

// governorate id map — matches backend governorate_id values
// used in both auth/setup and profile/personal_data
const List<Map<String, dynamic>> kGovernorates = [
  {'id': 1, 'name': 'القاهرة'},
  {'id': 2, 'name': 'الجيزة'},
  {'id': 3, 'name': 'الإسكندرية'},
  {'id': 4, 'name': 'الدقهلية'},
  {'id': 5, 'name': 'الشرقية'},
  {'id': 6, 'name': 'المنوفية'},
  {'id': 7, 'name': 'الغربية'},
  {'id': 8, 'name': 'كفر الشيخ'},
  {'id': 9, 'name': 'دمياط'},
  {'id': 10, 'name': 'بورسعيد'},
  {'id': 11, 'name': 'الإسماعيلية'},
  {'id': 12, 'name': 'السويس'},
  {'id': 13, 'name': 'شمال سيناء'},
  {'id': 14, 'name': 'جنوب سيناء'},
  {'id': 15, 'name': 'البحيرة'},
  {'id': 16, 'name': 'مرسى مطروح'},
  {'id': 17, 'name': 'الفيوم'},
  {'id': 18, 'name': 'بني سويف'},
  {'id': 19, 'name': 'المنيا'},
  {'id': 20, 'name': 'أسيوط'},
  {'id': 21, 'name': 'سوهاج'},
  {'id': 22, 'name': 'قنا'},
  {'id': 23, 'name': 'الأقصر'},
  {'id': 24, 'name': 'أسوان'},
  {'id': 25, 'name': 'البحر الأحمر'},
  {'id': 26, 'name': 'الوادي الجديد'},
];
