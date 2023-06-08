// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


class GetEntry extends StatelessWidget {
  GetEntry(
      {super.key,
      required this.entry,});
  OverlayEntry? entry;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              entry!.remove();
            },
            child: Container(
              color: const Color.fromARGB(83, 73, 59, 59),
            ),
          ),
        ),
        Positioned(
          top: (size.height / 2) - 100,
          left: 25,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              height: 200,
              width: size.width - 50,
              child: Column(
                children: [

                ],
              )
            ),
          ),
        ),
      ],
    );
  }
}