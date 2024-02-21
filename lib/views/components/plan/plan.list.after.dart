import 'package:fit_worker/views/components/plan/plan.card.dart';
import 'package:flutter/material.dart';
import "package:fit_worker/utils/constants.dart";

class PlanListAfter extends StatelessWidget {
  const PlanListAfter({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      primary: false,
      itemCount: planCardsafter.length,
      itemBuilder: (context, index) {
        return PlanCard(
          planCard: planCardsafter[index],
        );
      },
    );
  }
}
