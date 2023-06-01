import 'package:app/modules/recruiter/domain/repositories/recruitment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RecruitmentEfficiency extends StatelessWidget {
  const RecruitmentEfficiency({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hiệu quả tuyển dụng',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            flexBox(Builder(builder: (_) {
              final list = _
                  .watch<RecruitmentProvider>((p) => p.listRecruitment)
                  .listRecruitment;
              return ElementWidget(
                label: 'Tin tuyển dụng hiển thị',
                color: Colors.orange.shade400,
                quantity: list.length,
                width: size.width / 2 - 20,
              );
            }),
                ElementWidget(
                  label: 'CV tiếp nhận',
                  color: Colors.green,
                  quantity: 0,
                  width: size.width / 2 - 20,
                )),
            const SizedBox(height: 6),
            ElementWidget(
              label: 'Cv ứng tuyển mới',
              color: Colors.redAccent,
              quantity: 0,
              width: size.width / 2 - 20,
            ),
          ],
        )
      ],
    );
  }

  Widget flexBox(Widget child1, Widget child2) => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(flex: 1, child: child1),
          const SizedBox(width: 6),
          Expanded(flex: 1, child: child2)
        ],
      );
}

class ElementWidget extends StatelessWidget {
  final String label;
  final Color color;
  final int quantity;
  final double width;
  const ElementWidget(
      {super.key,
      required this.label,
      required this.color,
      required this.quantity,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      width: width,
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          quantity.toString(),
          style: TextStyle(color: color),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(color: color),
        ),
      ]),
    );
  }
}
