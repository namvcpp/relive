import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SearchBarComponent extends StatelessWidget {
  final String description;
  const SearchBarComponent(this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: description,
          icon: const Icon(LineAwesomeIcons.search),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
