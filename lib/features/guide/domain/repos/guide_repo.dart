import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/guide/domain/entities/articles_response.dart';

abstract class GuideRepo {
  Future<Either<Failure, ArticlesResponse>> getArticles({String? cursor});
}
