import 'package:flutter/material.dart';
import 'package:flutter_base/models/enums/profile_menu.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    required this.menu,
    required this.onMenuTapped,
    super.key,
  });
  final ProfileMenu menu;
  final VoidCallback onMenuTapped;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        menu.icon,
        size: 24,
        color: Colors.black.withOpacity(0.7),
      ),
      title: Text(menu.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: onMenuTapped,
    );
  }
}
