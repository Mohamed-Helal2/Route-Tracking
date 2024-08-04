import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routetracking/core/helper/douce.dart';
import 'package:routetracking/core/widget/custom_text_form_field.dart';
import 'package:routetracking/feature/google_map_view/logic/cubit/googlemap_cubit.dart';
import 'package:routetracking/feature/widget/search_result_view.dart';

class searchTextField extends StatelessWidget {
  searchTextField({
    super.key,
  });
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
                  context.read<GooglemapCubit>().getprediction();
                });
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
            suffixIcon: BlocBuilder<GooglemapCubit, GooglemapState>(
              builder: (context, state) {
                if (state is placeloading) {
                  return const Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                } else if (context
                    .read<GooglemapCubit>()
                    .textEditingController
                    .text
                    .isNotEmpty) {
                  return IconButton(
                      onPressed: () {
                        context
                            .read<GooglemapCubit>()
                            .textEditingController
                            .clear();
                        context.read<GooglemapCubit>().clearPredictions();
                      },
                      icon: const Icon(
                        Icons.disabled_by_default_sharp,
                        size: 30,
                      ));
                } else {
                  return const Icon(
                    Icons.search,
                    size: 30,
                  );
                }
              },
            ),
            preficicon: const Icon(
              Icons.map_sharp,
              size: 30,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          const search_result_view(),
        ],
      ),
    );
  }
}
