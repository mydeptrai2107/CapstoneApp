import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final String hinText;
  const SearchBox({super.key, required this.hinText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: SizedBox(
          height: 42,
          child: TextField(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                hintText:hinText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(width: 0.5))),
          ),
        )),
        const SizedBox(width: 8),
        SizedBox(
          height: 42,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            child: const Text(
              'Tìm kiếm',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
