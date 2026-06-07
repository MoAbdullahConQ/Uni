import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/notifications/domain/repos/notifications_repo.dart';

class MarkAllNotificationsAsReadUseCase {
  final NotificationsRepo notificationsRepo;

  MarkAllNotificationsAsReadUseCase(this.notificationsRepo);

  Future<Either<Failure, void>> call() {
    return notificationsRepo.markAllAsRead();
  }
}
