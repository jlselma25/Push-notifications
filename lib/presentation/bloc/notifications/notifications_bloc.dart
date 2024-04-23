
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app_new/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}



class NotificationsBloc extends Bloc<NotificationsEvent,NotificationsState>{

  FirebaseMessaging messaging = FirebaseMessaging.instance;  

  NotificationsBloc(): super(const NotificationsState()){
    on<NotificationStatusEvent>(((event, emit) =>_notificationStatusEvent(event, emit) )); 

    _initialStatusCheck();
    _onForegroundMessage();



  }




  static Future<void> initializeFireBaseCM() async{
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  }



  void _notificationStatusEvent(NotificationStatusEvent event,Emitter<NotificationsState> emit){

    emit(
      state.copyWhit(
        status: event.status
      )
    );
    _getTokenFCM();

  }    

   void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();    
    add(NotificationStatusEvent(settings.authorizationStatus));
    _getTokenFCM();
   }

    void _getTokenFCM() async{
      //final settings = await messaging.getNotificationSettings(); 
     if (state.status != AuthorizationStatus.authorized) return;  

     final token = await messaging.getToken();
     print(token);
    
  }
   

   void _handleRemoteMessage(RemoteMessage message){

      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification == null) return;
         
      print('Message also contained a notification: ${message.notification}');

   }


   void _onForegroundMessage(){
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
   }

   void requestPermision() async{
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    add(NotificationStatusEvent(settings.authorizationStatus));
   
  //_getTokenFCM();
   //settings.authorizationStatus;
  }
}