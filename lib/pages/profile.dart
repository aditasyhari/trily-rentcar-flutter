import 'package:flutter/cupertino.dart';
import 'package:trily/helpers/ColorsSys.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Akun', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SmallUserCard(
                cardColor: ColorSys.secoundry,
                backgroundMotifColor: Colors.blue[900],
                userName: "Adit Asyhari",
                userProfilePic: AssetImage("assets/images/profile.jpg"), 
                userMoreInfo: Text("Simple Happy", style: TextStyle(color: Colors.white70)),
                onTap: () {},
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: CupertinoIcons.pencil_outline,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: ColorSys.primary,
                    ),
                    title: 'Profile',
                    subtitle: "Edit profile",
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.history,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: ColorSys.secoundryLight,
                    ),
                    title: 'Transaksi',
                    subtitle: "Riwayat transaksi di Trily",
                  ),
                ],
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.info_rounded,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.purple,
                    ),
                    title: 'About',
                    subtitle: "Tentang aplikasi Trily",
                  ),
                ],
              ),
              SettingsGroup(
                // settingsGroupTitle: "Akun",
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.exit_to_app_rounded,
                    title: "Keluar",
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: CupertinoIcons.repeat,
                    title: "Ganti email",
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: CupertinoIcons.delete_solid,
                    title: "Hapus akun",
                    titleStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
