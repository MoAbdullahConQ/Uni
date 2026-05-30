import 'package:dartz/dartz.dart';
import 'package:uni/core/entities/unis_response.dart';
import 'package:uni/core/errors/custom_exceptions.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/search/data/data_sources/search_remote_data_source.dart';
import 'package:uni/features/search/domain/entities/search_filter_entity.dart';
import 'package:uni/features/search/domain/repos/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UnisResponse>> search({
    required String query,
    required SearchFilterEntity filter,
    String? cursor,
  }) async {
    try {
      final response = await remoteDataSource.search(
        query: query,
        filter: filter,
        cursor: cursor,
      );
      return right(response);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
