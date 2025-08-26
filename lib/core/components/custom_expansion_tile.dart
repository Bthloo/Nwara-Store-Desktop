import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({super.key,required this.title,required this.children});
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
     // expandedAlignment: Alignment.centerLeft,

      initiallyExpanded: true,
      collapsedShape: const BorderDirectional(
        top: BorderSide(
            color: Colors.transparent                        ),
        bottom: BorderSide(
            color: Colors.transparent                        ),
      ),
      shape: const BorderDirectional(
        top: BorderSide(
            color: Colors.transparent                        ),
        bottom: BorderSide(
            color: Colors.transparent                        ),
      ),
      title:  Text(
        title,
        style:  Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),),
      children: children
    );
  }
}
