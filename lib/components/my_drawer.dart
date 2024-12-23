import 'package:crud_tuto/components/my_drawer_tile.dart';
import 'package:crud_tuto/pages/login_or_register_page.dart';
import 'package:crud_tuto/pages/profil_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/home_page.dart';
import '../pages/search_page.dart';
import '../pages/settings_page.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // app logo
          Padding(
            padding: const EdgeInsets.only(top:80.0),
            child: Icon(
              Icons.lock_open_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
          // home list tile
          MyDrawerTile(
              text: 'H O M E',
              icon: Icons.home,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>const HomePage(),
                    )
                );
              }
          ),

          MyDrawerTile(
              text: 'S E A R C H ',
              icon: Icons.search,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>const SearchPage(),
                    )
                );
              }
          ),

          MyDrawerTile(
              text: 'P R O F I L E ',
              icon: Icons.person,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>const ProfilPage(),
                    )
                );
              }
          ),
          MyDrawerTile(
              text: 'S E T T I N G ',
              icon: Icons.settings,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>const SettingsPage(),
                )
                );
              }
          ),
          const Spacer(),

          MyDrawerTile(
            text: 'L O G O U T ',
            icon: Icons.logout,
            onTap: () async {
              // Fermer le drawer avant de faire d'autres actions
              Navigator.pop(context);

              // Déconnecter l'utilisateur de Firebase
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();



              // Rediriger vers la page de connexion
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginOrRegisterPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 25,),

        ],
      ),

    );
  }
}
