import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routetracking/feature/google_map_view/logic/cubit/googlemap_cubit.dart';
import 'package:routetracking/feature/widget/search_test.dart';
import 'package:routetracking/feature/widget/search_text_field.dart';

class CustomGoogleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<GooglemapCubit, GooglemapState>(
          builder: (context, state) {
            return SafeArea(
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition:
                        context.read<GooglemapCubit>().initialCameraPosition,
                    markers: context.read<GooglemapCubit>().markers,
                    onMapCreated: (controller) {
                      context.read<GooglemapCubit>().googleMapController =
                          controller;
                      context.read<GooglemapCubit>().updatemylocation();
                    },
                  ),
                // SearchTest()
                  searchTextField(),
                ],
              ),
            );
          },
        ));
  }
}
