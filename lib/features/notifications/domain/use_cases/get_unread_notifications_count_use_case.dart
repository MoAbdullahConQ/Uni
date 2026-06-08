import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/notifications/domain/repos/notifications_repo.dart';

class GetUnreadNotificationsCountUseCase {
  final NotificationsRepo notificationsRepo;

  GetUnreadNotificationsCountUseCase(this.notificationsRepo);

  Future<Either<Failure, int>> call() {
    return notificationsRepo.getUnreadCount();
  }
}
