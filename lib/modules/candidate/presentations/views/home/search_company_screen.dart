import 'package:app/modules/candidate/data/models/company_model.dart';
import 'package:app/modules/candidate/domain/providers/provider_company.dart';
import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:app/modules/candidate/presentations/views/home/widgets/item_company_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Company> listCompany = [];

  initData() async {
    _searchController.text == ''
        ? listCompany = []
        : listCompany = await Modular.get<ProviderCompany>()
            .getCompanyByName(_searchController.text);
  }

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
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ItemCompanyHorizontal(company: listCompany[index]);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 20,
            );
          },
          itemCount: listCompany.length),
    );
  }
}
