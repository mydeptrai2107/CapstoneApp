import 'package:app/modules/recruiter/presentations/views/management/widgets/button_filter.dart';
import 'package:flutter/material.dart';
import 'package:app/modules/recruiter/presentations/widgets/search_box.dart';

class ManagementScreen extends StatelessWidget {
  const ManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ButtonFilter(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: SearchBox(
              hinText: 'Tìm kiếm tên, email, sđt',
            ),
          ),
        ],
      ),
    );
  }
}
