import 'package:dartz/dartz.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/errors/custom_exeptions.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/browse/data/data_sources/browse_remote_data_source.dart';
import 'package:uni/features/browse/domain/repos/browse_repo.dart';

class BrowseRepoImpl implements BrowseRepo {
  final BrowseRemoteDataSource remoteDataSource;

  BrowseRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<UniEntity>>> getUnis() async {
    try {
      final unis = await remoteDataSource.getUnis();
      return right(unis);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
