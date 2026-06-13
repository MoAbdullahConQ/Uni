import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/custom_exceptions.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/uni_detail/data/data_sources/uni_detail_remote_data_source.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_detail_entity.dart';
import 'package:uni/features/uni_detail/domain/repos/uni_detail_repo.dart';

class UniDetailRepoImpl implements UniDetailRepo {
  final UniDetailRemoteDataSource remoteDataSource;

  UniDetailRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UniDetailEntity>> getUniDetail(int id) async {
    try {
      final response = await remoteDataSource.getUniDetail(id);
      return right(response);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
