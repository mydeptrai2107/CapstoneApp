import 'package:app/configs/font_style_text.dart';
import 'package:app/configs/image_factory.dart';
import 'package:app/configs/text_app.dart';
import 'package:app/data/models/profile_model.dart';
import 'package:app/domain/providers/provider_profile.dart';
import 'package:app/presentations/views/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeCreateCV extends StatefulWidget {
  const WelcomeCreateCV({super.key});

  @override
  State<WelcomeCreateCV> createState() => _WelcomeCreateCVState();
}

class _WelcomeCreateCVState extends State<WelcomeCreateCV> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProvideProfile>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quản lý CV',
          style: textStyleTitleAppBar,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              TextApp.createFirstCV,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              TextApp.createFirstCV,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 15),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              TextApp.letisCreateCvNow,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 16),
            ),
            SizedBox(height: 20.h),
            ButtonApp(
              title: 'Tạo CV đầu tiên',
              onPress: () async {
                List<Profile> a = await provider.getListProfile();
                print(a.length);
                //Modular.to.pushNamed(RoutePath.fillFirstInfoCV);
              },
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              height: 250.h,
              width: 250.h,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(ImageFactory.editCV))),
            )
          ],
        ),
      ),
    );
  }
}
