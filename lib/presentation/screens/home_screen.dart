import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app_new/presentation/bloc/notifications/notifications_bloc.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  context.select((NotificationsBloc bloc)
        {
          return  Text('${bloc.state.status}');
        }),
        
       
        
        
        actions: [
          IconButton(
            onPressed: (){
               context.read<NotificationsBloc>().requestPermision();
              
            }, 
            icon: const Icon(Icons.settings)
            )
        ],
      ),
      body: const _HomeView(),
    );
  }
}


class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context,index){

        return  const ListTile(
          title: Text('hola'),
        );

      }
      );
  }
}