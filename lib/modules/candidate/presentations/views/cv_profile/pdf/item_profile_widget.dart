// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:app/configs/image_factory.dart';
import 'package:app/configs/route_path.dart';
import 'package:app/modules/candidate/domain/providers/provider_profile.dart';
import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:app/modules/candidate/presentations/views/widgets/button_app.dart';
import 'package:app/modules/candidate/presentations/views/widgets/button_outline.dart';
import 'package:app/shared/utils/format.dart';
import 'package:app/shared/utils/notiface_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemProfileWidget extends StatefulWidget {
  const ItemProfileWidget(
      {super.key,
      required this.name,
      required this.id,
      this.pathCV,
      required this.reLoadList,
      required this.updateAt});

  final String name;
  final String id;
  final String? pathCV;
  final VoidCallback reLoadList;
  final DateTime updateAt;

  @override
  State<ItemProfileWidget> createState() => _ItemProfileWidgetState();
}

class _ItemProfileWidgetState extends State<ItemProfileWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = context.watch<ProviderProfile>();
    return Row(
      children: [
        Container(
          width: size.width - 30,
          height: 150,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        OverlayEntry? overlayEntry;
                        overlayEntry = OverlayEntry(
                          builder: (BuildContext context) {
                            return GetEntry(
                              entry: overlayEntry,
                              nameCV: widget.name,
                              onTap: () {
                                provider.deleteProfile(widget.id);
                                widget.reLoadList();
                                overlayEntry!.remove();
                              },
                            );
                          },
                        );
                        Overlay.of(context).insert(overlayEntry);
                      } catch (e) {
                        notifaceError(
                            context, jsonDecode(e.toString())['message']);
                      }
                    },
                    child: !provider.isLoadingDelete
                        ? const CircularProgressIndicator()
                        : SvgPicture.asset(
                            ImageFactory.delete,
                            color: Colors.red,
                            width: 25,
                            height: 25,
                          ),
                  )
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageFactory.time,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    Format.formatDateTimeToYYYYmmHHmm(widget.updateAt),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageFactory.information,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Create on JobCV  ',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonOutline(
                      fontSize: 15,
                      title: 'PREVIEW',
                      onPress: () {
                        if (widget.pathCV != null) {
                          Modular.to.pushNamed(RoutePath.pdfViewer,
                              arguments: [widget.name, widget.pathCV]);
                        }
                      },
                      borderRadius: 5,
                      width: (size.width - 70) / 2),
                  ButtonOutline(
                    fontSize: 15,
                    title: 'EDIT',
                    onPress: () {},
                    borderRadius: 5,
                    width: (size.width - 70) / 2,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class GetEntry extends StatelessWidget {
  GetEntry(
      {super.key,
      required this.entry,
      required this.nameCV,
      required this.onTap});
  OverlayEntry? entry;
  final String nameCV;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              entry!.remove();
            },
            child: Container(
              color: const Color.fromARGB(83, 73, 59, 59),
            ),
          ),
        ),
        Positioned(
          top: (size.height / 2) - 100,
          left: 25,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              height: 200,
              width: size.width - 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Bạn có chắn chắn muốn xóa $nameCV',
                    style: const TextStyle(color: primaryColor, fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonApp(
                          height: 60,
                          width: (size.width - 100) / 2,
                          title: 'Xác nhận',
                          onPress: onTap),
                      ButtonOutline(
                        height: 60,
                        width: (size.width - 100) / 2,
                        title: 'Hủy',
                        onPress: () {
                          entry!.remove();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
