import 'package:app/configs/route_path.dart';
import 'package:app/modules/recruiter/domain/repositories/recruitment_provider.dart';
import 'package:app/shared/models/recruitment_model.dart';
import 'package:app/shared/presentations/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddRecruitment extends StatelessWidget {
  const AddRecruitment({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Tạo tin tuyển dụng'),
        IconButton(
            onPressed: () => Modular.to.pushNamed(RoutePath.addRecruitment),
            icon: const Icon(Icons.add))
      ],
    );
  }
}

class AddRecruitmentScreen extends StatelessWidget {
  AddRecruitmentScreen({super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController requestController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController benefitController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  _addRecruitment(Recruitment recruitment) async {
    await Modular.get<RecruitmentProvider>().createRecruitment(recruitment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo tin tuyển dụng'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                  controller: titleController,
                  hintText: 'Tiêu đề',
                  icon: const Icon(Icons.title)),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: CustomTextField(
                        controller: salaryController,
                        hintText: 'Mức lương',
                        icon: const Icon(Icons.attach_money)),
                  ),
                  const SizedBox(width: 8.0),
                  Flexible(
                    flex: 1,
                    child: CustomTextField(
                        controller: qtyController,
                        hintText: 'Số lượng',
                        icon: const Icon(Icons.people)),
                  ),
                ],
              ),
              CustomTextField(
                  controller: positionController,
                  hintText: 'Vị trí',
                  icon: const Icon(Icons.account_box_outlined)),
              CustomTextField(
                  controller: descriptionController,
                  hintText: 'Miêu tả',
                  icon: const Icon(Icons.description_outlined)),
              CustomTextField(
                  controller: requestController,
                  hintText: 'Yêu cầu',
                  icon: const Icon(Icons.request_page_outlined)),
              CustomTextField(
                  controller: benefitController,
                  hintText: 'Lợi ích',
                  icon: const Icon(Icons.wysiwyg)),
              CustomTextField(
                  controller: addressController,
                  hintText: 'Địa điểm làm việc',
                  icon: const Icon(Icons.location_on_outlined)),
            ],
          ),
        ),
      ),
    );
  }
}
