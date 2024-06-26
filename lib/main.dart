
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app_new/config/router/app_router.dart';
import 'package:push_app_new/config/theme/app_theme.dart';
import 'presentation/bloc/notifications/notifications_bloc.dart';

void main() async{
  
 WidgetsFlutterBinding.ensureInitialized();
 FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
 await NotificationsBloc.initializeFireBaseCM();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => NotificationsBloc())    
    ],
    child: const MainApp()
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
     
    );
  }
}
