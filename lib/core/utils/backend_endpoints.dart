class BackendEndpoints {
  static const String baseUrl =
      'https://back.laraveladvancedsayed101.cloud/api';

  // Universities
  static const String getUniversities = '/universities';
  static const String getTrendingUnis = '/universities/trendy';
  static String getUniDetail(int id) => '/universities/$id';

  // Colleges
  static const String getColleges = '/colleges';
  static String getCollegesByUni(int universityId) => '/colleges/$universityId';

  // Graduates
  static String getGraduatesByUni(int universityId) =>
      '/graduates/$universityId';

  // University Life
  static String getUniLife(int universityId) =>
      '/university_life/$universityId';

  // University Fav
  static const String addToFav = '/university_fav/add';
  static const String removeFromFav = '/university_fav/remove';
  static const String getFavs = '/university_fav';

  // Notifications
  static const String getNotifications = '/notifications';
  static const String getUnreadNotificationsCount =
      '/notifications/count-unread';
  static String markNotificationAsRead(int id) =>
      '/notifications/mark-as-read/$id';
  static const String markAllNotificationsAsRead = '/notifications/markall';

  // Articles
  static const String getArticles = '/articles';

  // Search
  static const String search = '/search-univ';
}
