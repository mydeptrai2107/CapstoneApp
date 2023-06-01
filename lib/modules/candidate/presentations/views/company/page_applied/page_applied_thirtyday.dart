import 'package:app/configs/image_factory.dart';
import 'package:app/modules/candidate/data/models/apply_model.dart';
import 'package:app/modules/candidate/data/models/user_model.dart';
import 'package:app/modules/candidate/domain/providers/provider_apply.dart';
import 'package:app/modules/candidate/domain/providers/provider_auth.dart';
import 'package:app/modules/candidate/domain/providers/provider_recruitment.dart';
import 'package:app/modules/candidate/presentations/views/company/page_applied/widgets/item_recruitment_applied.dart';
import 'package:app/shared/models/recruitment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PageAppliedThirtyDay extends StatefulWidget {
  const PageAppliedThirtyDay({super.key});

  @override
  State<PageAppliedThirtyDay> createState() => _PageAppliedThirtyDayState();
}

class _PageAppliedThirtyDayState extends State<PageAppliedThirtyDay> {
  List<Apply> list = [];
  List<Recruitment> listRecruit = [];
  bool isLoading = false;

  initData() async {
    setState(() {
      isLoading = true;
    });
    User user = await Modular.get<ProviderAuth>().getUser();
    list = await Modular.get<ProviderApply>().getListApply30Day(user.userId);
    list.map((e) async {
      Recruitment recruitment = await Modular.get<ProviderRecruitment>()
          .getRecruitById(e.recruitmentId);
      listRecruit.add(recruitment);
    }).toList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    context.watch<ProviderAuth>();
    context.watch<ProviderApply>();
    context.watch<ProviderRecruitment>();

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : listRecruit.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ImageFactory.box),
                            fit: BoxFit.fill)),
                  ),
                  const Text(
                    'Danh sách tin tuyển dụng trống',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )
                ],
              )
            : Container(
                height: size.height,
                width: size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ItemRecruitApplied(
                          recruitment: listRecruit[index]);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                    itemCount: listRecruit.length),
              );
  }
}
