import 'package:app/modules/recruiter/data/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final list = context
        .watch<NotificationProvider>((p) => p.remoteMessage)
        .remoteMessage;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 41, 63, 78),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, index) {
            final item = list[index];
            return Text(item.data.toString());
          }),
    );
  }
}
