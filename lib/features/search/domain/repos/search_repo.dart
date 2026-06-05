import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/core/entities/unis_response.dart';
import 'package:uni/features/search/domain/entities/search_filter_entity.dart';

abstract class SearchRepo {
  Future<Either<Failure, UnisResponse>> search({
    required String query,
    required SearchFilterEntity filter,
    String? cursor,
  });
  
  Future<Either<Failure, List<String>>> getSpecialties();
}
