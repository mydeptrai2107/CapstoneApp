import 'package:app/modules/candidate/data/models/company_model.dart';
import 'package:flutter/material.dart';

class ItemCompanyHorizontal extends StatelessWidget {
  const ItemCompanyHorizontal({super.key, required this.company});
  final Company company;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey)
      ),
      height: 100,
      child: Center(
        child: Text(company.name),
      ),
    );
  }
}
