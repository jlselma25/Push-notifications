part of 'notifications_bloc.dart';

abstract class NotificationsEvent {
  const NotificationsEvent();
}


class NotificationStatusEvent extends NotificationsEvent{
  final AuthorizationStatus status ;
  NotificationStatusEvent(this.status);
}