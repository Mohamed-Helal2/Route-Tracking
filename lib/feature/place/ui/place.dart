import 'package:flutter/material.dart';
import 'package:routetracking/core/widget/custom_text_form_field.dart';
import 'package:routetracking/feature/widget/search_test.dart';
import 'package:routetracking/feature/widget/search_text_field.dart';

class Place extends StatelessWidget {
  const Place({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return const ListTile(
                  title: Text("Test"),
                );
              },
            ),
            searchTextField()
          ],
        ),
      ),
    );
  }
}
