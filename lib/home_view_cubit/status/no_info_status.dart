import 'package:flutter/material.dart';

class NoInfoStatus extends StatelessWidget {
  const NoInfoStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("There is no information",style: TextStyle(fontSize: 25,),));
  }
}
