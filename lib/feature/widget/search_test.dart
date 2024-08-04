import 'package:flutter/material.dart';
import 'package:routetracking/core/widget/custom_text_form_field.dart';
import 'package:routetracking/feature/place/ui/place.dart';

class SearchTest extends StatelessWidget {
  const SearchTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 10,
      right: 10,
      child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Place(),
            ));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.white,
                borderRadius: BorderRadius.circular(50)),
            child: Row(
              children: [
                Icon(
                  Icons.map,
                  size: 35,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Search Here")
              ],
            ),
          )
          //  const AppTextFormField(
          //   hintText: "Search Here",
          //   enabledBorder: const OutlineInputBorder(
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(50),
          //     ),
          //   ),
          //   suffixIcon: const Icon(
          //     Icons.mic,
          //     size: 35,
          //   ),
          //   preficicon: const Icon(
          //     Icons.map_sharp,
          //     size: 35,
          //   ),
          ),
    );
  }
}
