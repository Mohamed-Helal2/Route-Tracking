import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routetracking/core/Service/places_service.dart';
import 'package:routetracking/core/helper/douce.dart';
import 'package:routetracking/core/widget/custom_text_form_field.dart';
import 'package:routetracking/feature/google_map_view/logic/cubit/googlemap_cubit.dart';

class searchTextField extends StatelessWidget {
  searchTextField({
    super.key,
    //required this.textEditingController,
  });
  // final TextEditingController textEditingController;
  final debouncer = Debouncer(
      delay: const Duration(milliseconds: 1000)); // 500 ms debounce time

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 10,
      right: 10,
      child: Column(
        children: [
          AppTextFormField(
              controller: context.read<GooglemapCubit>().textEditingController,
              onChanged: (p0) {
                if (p0.isNotEmpty) {
                  debouncer(() {
                    print("----- ${p0}");
                    context.read<GooglemapCubit>().getprediction();
                    // context.read<GooglemapCubit>().prediction_resulrt.clear();
                  });
                } else {
                  //context.read<GooglemapCubit>().clearPredictions();
                }
              },

              // textEditingController,
              hintText: "Search here",
              // autofocus: true,
              fillColor: Colors.white,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              suffixIcon: const Icon(
                Icons.mic,
                size: 30,
              ),
              preficicon: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.map_sharp,
                  size: 30,
                ),
              )),
          BlocBuilder<GooglemapCubit, GooglemapState>(
            builder: (context, state) {
              return ListView.separated(
                itemCount:
                    context.read<GooglemapCubit>().prediction_resulrt.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return context
                          .read<GooglemapCubit>()
                          .prediction_resulrt
                          .isNotEmpty
                      ? Text(
                          '-- ${context.read<GooglemapCubit>().prediction_resulrt[index].description}')
                      : null;
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class valdiate_button extends StatelessWidget {
  const valdiate_button({
    super.key,
    required this.placesService,
  });

  final PlacesService placesService;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 3,
      left: 3,
      child: MaterialButton(
        onPressed: () {
          print("--- ${placesService.getpredictions(input: 'cairo')}");
        },
        child: Text('Search'),
        color: Colors.red,
      ),
    );
  }
}
