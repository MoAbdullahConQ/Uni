import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/custom_exceptions.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/guide/data/data_sources/guide_remote_data_source.dart';
import 'package:uni/features/guide/domain/entities/articles_response.dart';
import 'package:uni/features/guide/domain/repos/guide_repo.dart';

class GuideRepoImpl implements GuideRepo {
  final GuideRemoteDataSource remoteDataSource;

  GuideRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ArticlesResponse>> getArticles({
    String? cursor,
  }) async {
    try {
      final response = await remoteDataSource.getArticles(cursor: cursor);
      return right(response);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
