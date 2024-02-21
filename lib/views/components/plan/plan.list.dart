import 'package:fit_worker/views/components/plan/plan.card.dart';
import 'package:flutter/material.dart';
import "package:fit_worker/utils/constants.dart";

class PlanList extends StatelessWidget {
  const PlanList({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      primary: false,
      itemCount: planCardsbefore.length,
      itemBuilder: (context, index) {
        return PlanCard(
          planCard: planCardsbefore[index],
          isLast: index == planCardsafter.length - 1,
        );
      },
    );
  }
}
