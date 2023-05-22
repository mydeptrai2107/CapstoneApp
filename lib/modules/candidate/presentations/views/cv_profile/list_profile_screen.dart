import 'package:app/configs/route_path.dart';
import 'package:app/modules/candidate/data/models/profile_model.dart';
import 'package:app/modules/candidate/domain/providers/provider_profile.dart';
import 'package:app/modules/candidate/presentations/views/cv_profile/pdf/item_profile_widget.dart';
import 'package:app/modules/candidate/presentations/views/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ListProfileScreen extends StatefulWidget {
  const ListProfileScreen({super.key});

  @override
  State<ListProfileScreen> createState() => _ListProfileScreenState();
}

class _ListProfileScreenState extends State<ListProfileScreen> {
  List<Profile> listProvider = [];
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    listProvider = await Modular.get<ProviderProfile>().getListProfile();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProviderProfile>();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('JobCV'),
        leading: IconButton(
            onPressed: () {
              Modular.to.pushNamed(RoutePath.welcomeCreateCV);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: !provider.isLoading
          ? const CircularProgressIndicator()
          : Container(
              padding: const EdgeInsets.only(left: 15),
              height: size.height,
              width: size.width,
              child: ListView.separated(
                itemCount: listProvider.length,
                itemBuilder: (context, index) {
                  return ItemProfileWidget(
                    name: listProvider[index].name,
                    id: listProvider[index].id,
                    pathCV: listProvider[index].pathCv,
                    reLoadList: () async {
                      listProvider = await provider.getListProfile();
                    },
                    updateAt: listProvider[index].updatedAt,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
              ),
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 1))),
        height: 85,
        width: size.width,
        child: ButtonApp(
          borderRadius: 10,
          title: 'Tiếp tục',
          onPress: () {
            Modular.to.pushNamed(RoutePath.fillFirstInfoCV);
          },
        ),
      ),
    );
  }
}
