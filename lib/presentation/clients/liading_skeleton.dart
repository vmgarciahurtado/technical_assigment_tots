import 'package:flutter/material.dart';
import 'package:thechnical_assignment_tots/presentation/shared/custom_card.dart';

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return CustomCard(
          body: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              color: Colors.grey[300],
            ),
            title: Container(
              width: double.infinity,
              height: 10,
              color: Colors.grey[300],
            ),
            subtitle: Container(
              width: double.infinity,
              height: 10,
              color: Colors.grey[200],
            ),
          ),
        );
      },
    );
  }
}
