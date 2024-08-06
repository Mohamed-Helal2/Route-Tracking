import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routetracking/feature/google_map_view/logic/cubit/googlemap_cubit.dart';

class search_result_view extends StatelessWidget {
  const search_result_view({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GooglemapCubit, GooglemapState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.separated(
            itemCount: context.read<GooglemapCubit>().prediction_resulrt.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  // print(
                  //     "<<--- ${context.read<GooglemapCubit>().prediction_resulrt[index].placeId}");
                  await context.read<GooglemapCubit>().updatetonewsearchlocation(
                      placeid: context
                          .read<GooglemapCubit>()
                          .prediction_resulrt[index]
                          .placeId!);
                  
                },
                child: ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.streetView,
                    color: Color.fromARGB(255, 31, 75, 111),
                  ),
                  title: Text(
                      '${context.read<GooglemapCubit>().prediction_resulrt[index].description}'),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_outward_rounded,
                        color: Color.fromARGB(255, 31, 75, 111),
                      )),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 0,
              );
            },
          ),
        );
      },
    );
  }
}
