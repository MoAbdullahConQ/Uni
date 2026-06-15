import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/auth/domain/repos/auth_repo.dart';

class SaveStudentInfoUseCase {
  final AuthRepo authRepo;

  SaveStudentInfoUseCase(this.authRepo);

  Future<Either<Failure, void>> call({
    required String studySection,
    required String scientificDepartment,
    required int governorateId,
    required double percentage,
    required int age,
  }) {
    return authRepo.saveStudentInfo(
      studySection: studySection,
      scientificDepartment: scientificDepartment,
      governorateId: governorateId,
      percentage: percentage,
      age: age,
    );
  }
}
