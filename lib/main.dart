import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routetracking/feature/google_map_view/custom_google_map.dart';
import 'package:routetracking/feature/google_map_view/logic/cubit/googlemap_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<GooglemapCubit>(
        create: (context) => GooglemapCubit(),
        child: CustomGoogleMap(),
      ),
      // theme: new ThemeData(
      //   primaryColor: Colors.white,
      //   // Add the line below to get horizontal sliding transitions for routes.
      //   pageTransitionsTheme: PageTransitionsTheme(builders: {
      //     TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      //   }),
      // ),
    );
  }
}

// text field =>search 