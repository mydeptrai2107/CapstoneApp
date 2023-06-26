import 'package:app/modules/recruiter/data/provider/recruitment_provider.dart';
import 'package:app/modules/recruiter/presentations/views/management/widgets/item_cv.dart';
import 'package:flutter/material.dart';
import 'package:app/modules/recruiter/presentations/widgets/search_box.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ManagementScreen extends StatelessWidget {
  ManagementScreen({super.key});
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const ButtonFilter(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SearchBox(
              hinText: 'Tìm kiếm tên',
              callback: () async {
                await context
                    .read<RecruitmentProvider>()
                    .searchListCV(textEditingController.text);
              },
              closeSearch: () async {
                textEditingController.clear();
                await context
                    .read<RecruitmentProvider>()
                    .searchListCV(textEditingController.text);
              },
              textEditingController: textEditingController,
            ),
          ),
          Expanded(child: Builder(builder: (_) {
            final list =
                _.watch<RecruitmentProvider>((p) => p.listApply).listApply;
            return GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              children: List.generate(list.length, (index) {
                final item = list[index];
                return ItemCV(apply: item);
              }),
            );
          }))
        ],
      ),
    );
  }
}
