import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_tuto/components/my_drawer.dart';
import 'package:crud_tuto/pages/plat_page.dart';
import 'package:crud_tuto/pages/salade_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'gateau_page.dart';
import 'jus_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userFirstName;
  @override
  void initState() {
    super.initState();
    _getUserFirstName();
  }

  Future<void> _getUserFirstName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        userFirstName = userData['firstName']; // Assurez-vous que 'firstName' correspond au champ que vous avez enregistré
      });
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenue ${userFirstName ?? ''}"),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [

        ],
      ),
      drawer: MyDrawer(),
      body:


      ListView(
        padding: const EdgeInsets.all(8),
        children: [
          const SizedBox(height: 30),
          // Exemple de carte de recette
          Card(
margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            color: Theme.of(context).colorScheme.secondary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(

                leading: Image.asset(
                  'lib/images/plats.jpg', // Chemin vers ton image locale
                  width: 220, // Ajuste la taille si nécessaire
                  height: 220, // Ajuste la taille si nécessaire


                  //fit: BoxFit.cover, // Permet de gérer le redimensionnement de l'image
                ),
                title:  Text("PLATS",
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),),
                subtitle:  Text("Vous trouverez tous les recettes de plats içi !",
                  style: TextStyle(

                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                    ),
                onTap: () {
                  // Action lors du clic sur une recette


                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=>const PlatPage(),
                      )
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            color: Theme.of(context).colorScheme.secondary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.asset(
                  'lib/images/salades.jpg', // Chemin vers ton image locale
                  width: 220, // Ajuste la taille si nécessaire
                  height: 220, // Ajuste la taille si nécessaire
                 // fit: BoxFit.cover, // Permet de gérer le redimensionnement de l'image
                ),
                title:  Text("SALADES",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),),
                subtitle:  Text("Vous trouverez tous les recettes de salades içi ! ",
                  style: TextStyle(

                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () {
                  // Action lors du clic sur une recette


                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=>const SaladePage(),
                      )
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            color: Theme.of(context).colorScheme.secondary,
            child: ListTile(
              leading: Image.asset(
                'lib/images/gateau.jpg', // Chemin vers ton image locale
                width: 220, // Ajuste la taille si nécessaire
                height: 220, // Ajuste la taille si nécessaire
                //fit: BoxFit.cover, // Permet de gérer le redimensionnement de l'image
              ),
              title:  Text("GATEAUX",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),),
              subtitle:  Text("Vous trouverez tous les recettes de gateaux içi !",
                style: TextStyle(

                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              onTap: () {
                // Action lors du clic sur une recette

                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>const GateauPage(),
                    )
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            color: Theme.of(context).colorScheme.secondary,
            child: ListTile(
              leading: Image.asset(
                'lib/images/jus.jpg', // Chemin vers ton image locale
                width: 220, // Ajuste la taille si nécessaire
                height: 220, // Ajuste la taille si nécessaire
                //fit: BoxFit.cover, // Permet de gérer le redimensionnement de l'image
              ),
              title:  Text("JUS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),),
              subtitle: Text("Vous trouverez tous les recettes des jus içi !",
                style: TextStyle(

                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              onTap: () {
                // Action lors du clic sur une recette

                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>const JusPage(),
                    )
                );
              },
            ),
          ),
          // Ajouter plus de cartes ou une boucle pour afficher une liste de recettes
        ],
      ),
    );
  }
}
