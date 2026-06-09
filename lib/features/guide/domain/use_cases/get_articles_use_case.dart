import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/guide/domain/entities/articles_response.dart';
import 'package:uni/features/guide/domain/repos/guide_repo.dart';

class GetArticlesUseCase {
  final GuideRepo guideRepo;

  GetArticlesUseCase(this.guideRepo);

  Future<Either<Failure, ArticlesResponse>> call({String? cursor}) {
    return guideRepo.getArticles(cursor: cursor);
  }
}
