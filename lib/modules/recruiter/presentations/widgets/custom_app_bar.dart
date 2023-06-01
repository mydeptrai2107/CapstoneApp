import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 41, 63, 78),
      title: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.black12,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Name Recruiter',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'Mã NTD: 2188',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          ActionButton(
            assetIcon: Ionicons.notifications,
            callback: () {},
          ),
          ActionButton(
            assetIcon: Ionicons.chatbubbles,
            callback: () {},
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ActionButton extends StatelessWidget {
  final IconData assetIcon;
  final VoidCallback callback;
  const ActionButton(
      {super.key, required this.assetIcon, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: callback,
            style: IconButton.styleFrom(
                backgroundColor: Colors.grey.withOpacity(0.5)),
            icon: Icon(
              assetIcon,
              size: 25,
              color: Colors.white,
            )),
        const Positioned(
            right: 0,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.red,
              child: Center(
                  child: Text(
                '12',
                style: TextStyle(fontSize: 10, color: Colors.white),
              )),
            ))
      ],
    );
  }
}
