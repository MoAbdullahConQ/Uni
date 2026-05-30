class BackendEndpoints {
  static const String baseUrl =
      'https://back.laraveladvancedsayed101.cloud/api';

  // Universities
  static const String getUniversities = '/universities';

  // University Fav
  static const String addToFav = '/university_fav/add';
  static const String removeFromFav = '/university_fav/remove';
  static const String getFavs = '/university_fav';
}
