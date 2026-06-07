import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/notifications/domain/repos/notifications_repo.dart';

class MarkNotificationAsReadUseCase {
  final NotificationsRepo notificationsRepo;

  MarkNotificationAsReadUseCase(this.notificationsRepo);

  Future<Either<Failure, void>> call(int notificationId) {
    return notificationsRepo.markAsRead(notificationId);
  }
}
