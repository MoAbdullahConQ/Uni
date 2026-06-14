import 'package:uni/core/utils/api_service.dart';
import 'package:uni/core/utils/backend_endpoints.dart';
import 'package:uni/features/guide/data/models/guide_article_model.dart';
import 'package:uni/features/guide/domain/entities/articles_response.dart';

abstract class GuideRemoteDataSource {
  Future<ArticlesResponse> getArticles({String? cursor});
}

class GuideRemoteDataSourceImpl implements GuideRemoteDataSource {
  final ApiService apiService;

  GuideRemoteDataSourceImpl(this.apiService);

  @override
  Future<ArticlesResponse> getArticles({String? cursor}) async {
    final response = await apiService.get(
      endpoint: BackendEndpoints.getArticles,
      queryParameters: {'per_page': 10, if (cursor != null) 'cursor': cursor},
    );

    final articles = (response['data'] as List)
        .map((json) => GuideArticleModel.fromJson(json))
        .toList();

    final nextCursor = response['meta']?['next_cursor'] as String?;

    return ArticlesResponse(articles: articles, nextCursor: nextCursor);
  }
}
