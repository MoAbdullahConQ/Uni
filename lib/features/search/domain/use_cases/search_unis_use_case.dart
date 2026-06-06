import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/core/entities/unis_response.dart';
import 'package:uni/features/search/domain/entities/search_filter_entity.dart';
import 'package:uni/features/search/domain/repos/search_repo.dart';

class SearchUnisUseCase {
  final SearchRepo searchRepo;

  SearchUnisUseCase(this.searchRepo);

  Future<Either<Failure, UnisResponse>> call({
    required String query,
    required SearchFilterEntity filter,
    int? page,
  }) {
    return searchRepo.search(query: query, filter: filter, page: page);
  }
}
