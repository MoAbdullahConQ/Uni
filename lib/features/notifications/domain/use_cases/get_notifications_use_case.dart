import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/notifications/domain/entities/notifications_response.dart';
import 'package:uni/features/notifications/domain/repos/notifications_repo.dart';

class GetNotificationsUseCase {
  final NotificationsRepo notificationsRepo;

  GetNotificationsUseCase(this.notificationsRepo);

  Future<Either<Failure, NotificationsResponse>> call({String? cursor}) {
    return notificationsRepo.getNotifications(cursor: cursor);
  }
}
