import 'package:app/configs/image_factory.dart';
import 'package:app/modules/candidate/data/models/recruitment_model.dart';
import 'package:app/modules/candidate/domain/providers/provider_company.dart';
import 'package:app/modules/candidate/domain/providers/provider_recruitment.dart';
import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:app/modules/candidate/presentations/views/home/widgets/item_recruitment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchRecruitmentScreen extends StatefulWidget {
  const SearchRecruitmentScreen({super.key});

  @override
  State<SearchRecruitmentScreen> createState() =>
      _SearchRecruitmentScreenState();
}

class _SearchRecruitmentScreenState extends State<SearchRecruitmentScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Recruitment> listRecruitment = [];

  initData() async {
    isSearched = true;
    _searchController.text == ''
        ? listRecruitment = []
        : listRecruitment = await Modular.get<ProviderRecruitment>()
            .getListRecruitByName(_searchController.text);
  }

  bool isSearched = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    context.watch<ProviderCompany>();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: primaryColor),
              borderRadius: BorderRadius.circular(10)),
          child: TextField(
            onSubmitted: (value) {
              initData();
            },
            controller: _searchController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                hintText: 'Tên công ty'),
          ),
        ),
      ),
      body: isSearched && listRecruitment.isEmpty
          ? SizedBox(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ImageFactory.searchNotFound),
                            fit: BoxFit.fill)),
                  ),
                  const Text(
                    'Không tìm thấy dữ liệu',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return ItemRecuitment(recruitment: listRecruitment[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemCount: listRecruitment.length),
    );
  }
}
