class UniModel {
  int? id;
  String? name;
  String? location;
  String? type;
  String? rate;
  String? isFavForMe;
  String? website;
  String? avatar;
  String? backgroundImage;
  String? avatarUrl;
  String? backgroundImageUrl;
  String? publicSummary;
  String? worldRanking;
  String? foundationDate;
  int? studentsCount;
  String? createdAt;

  UniModel({
    this.id,
    this.name,
    this.location,
    this.type,
    this.rate,
    this.isFavForMe,
    this.website,
    this.avatar,
    this.backgroundImage,
    this.avatarUrl,
    this.backgroundImageUrl,
    this.publicSummary,
    this.worldRanking,
    this.foundationDate,
    this.studentsCount,
    this.createdAt,
  });

  factory UniModel.fromJson(Map<String, dynamic> json) {
    return UniModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      location: json['location'] as String?,
      type: json['type'] as String?,
      rate: json['rate'] as String?,
      isFavForMe: json['is_fav_for_me'] as String?,
      website: json['website'] as String?,
      avatar: json['avatar'] as String?,
      backgroundImage: json['background_image'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      backgroundImageUrl: json['background_image_url'] as String?,
      publicSummary: json['public_summary'] as String?,
      worldRanking: json['world_ranking'] as String?,
      foundationDate: json['foundation_date'] as String?,
      studentsCount: json['students_count'] as int?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'location': location,
    'type': type,
    'rate': rate,
    'is_fav_for_me': isFavForMe,
    'website': website,
    'avatar': avatar,
    'background_image': backgroundImage,
    'avatar_url': avatarUrl,
    'background_image_url': backgroundImageUrl,
    'public_summary': publicSummary,
    'world_ranking': worldRanking,
    'foundation_date': foundationDate,
    'students_count': studentsCount,
    'created_at': createdAt,
  };
}
