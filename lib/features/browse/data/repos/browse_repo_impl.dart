import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/custom_exceptions.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/browse/data/data_sources/browse_remote_data_source.dart';
import 'package:uni/core/entities/unis_response.dart';
import 'package:uni/features/browse/domain/repos/browse_repo.dart';

class BrowseRepoImpl implements BrowseRepo {
  final BrowseRemoteDataSource remoteDataSource;

  BrowseRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UnisResponse>> getUnis({String? cursor}) async {
    try {
      final response = await remoteDataSource.getUnis(cursor: cursor);
      return right(response);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
