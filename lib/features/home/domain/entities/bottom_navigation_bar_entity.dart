import 'package:uni/core/utils/app_images.dart';

class BottomNavigationBarEntity {
  final String activeImage, inActiveImage;
  final String name;

  const BottomNavigationBarEntity({
    required this.activeImage,
    required this.inActiveImage,
    required this.name,
  });
}

List<BottomNavigationBarEntity> get bottomNavigationBarItems => const [
  BottomNavigationBarEntity(
    activeImage: Assets.imagesBoldNavHome,
    inActiveImage: Assets.imagesOutlineNavHome,
    name: 'الرئيسية',
  ),
  BottomNavigationBarEntity(
    activeImage: Assets.imagesBoldNavDalil,
    inActiveImage: Assets.imagesOutlineNavDalil,
    name: 'الدليل الجامعي',
  ),
  BottomNavigationBarEntity(
    activeImage: Assets.imagesBoldNavFav,
    inActiveImage: Assets.imagesOutlineNavFav,
    name: 'المفضلة',
  ),
  BottomNavigationBarEntity(
    activeImage: Assets.imagesBoldNavProfile,
    inActiveImage: Assets.imagesOutlineNavProfile,
    name: 'حسابي',
  ),
];
