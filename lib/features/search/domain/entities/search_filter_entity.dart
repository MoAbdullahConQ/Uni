class SearchFilterEntity {
  final double minFees;
  final double maxFees;
  final List<String> selectedSpecialties;
  final List<String> selectedTypes;

  const SearchFilterEntity({
    this.minFees = 10000,
    this.maxFees = 250000,
    this.selectedSpecialties = const [],
    this.selectedTypes = const [],
  });

  int get activeFiltersCount =>
      selectedSpecialties.length + selectedTypes.length;

  SearchFilterEntity copyWith({
    double? minFees,
    double? maxFees,
    List<String>? selectedSpecialties,
    List<String>? selectedTypes,
  }) {
    return SearchFilterEntity(
      minFees: minFees ?? this.minFees,
      maxFees: maxFees ?? this.maxFees,
      selectedSpecialties: selectedSpecialties ?? this.selectedSpecialties,
      selectedTypes: selectedTypes ?? this.selectedTypes,
    );
  }
}
