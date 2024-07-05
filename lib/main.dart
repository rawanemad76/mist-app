import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mist_app/home_view_cubit/get_road_cubit/get_road_cubit.dart';
import 'auth_wrapper.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const Mist());
}

class Mist extends StatelessWidget {
  const Mist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>GetRoadCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: SplashScreen(),
        // home: SelectRoad(),
        // home: UserNavBar(),
        // home: SignUpScreen1(),
        home: AuthWrapper(),

        // home: CoordinatorUID(),
      ),
    );
  }
}


