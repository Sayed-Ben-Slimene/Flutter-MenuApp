import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_tuto/components/my_drawer.dart';
import 'package:crud_tuto/pages/plat_page.dart';
import 'package:crud_tuto/pages/salade_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'gateau_page.dart';
import 'jus_page.dart';

class ChefPage extends StatefulWidget {
  const ChefPage({super.key});

  @override
  State<ChefPage> createState() => _ChefPageState();
}

class _ChefPageState extends State<ChefPage> {
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
        userFirstName = userData['firstName'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenue Chef ${userFirstName ?? ''}"),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      drawer: MyDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          const SizedBox(height: 30),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Theme.of(context).colorScheme.secondary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.asset(
                  'lib/images/plats.jpg',
                  width: 220,
                  height: 220,
                ),
                title: Text(
                  "PLATS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                subtitle: Text(
                  "Vous trouverez tous les recettes de plats içi !",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PlatPage(),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Theme.of(context).colorScheme.secondary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.asset(
                  'lib/images/salades.jpg',
                  width: 220,
                  height: 220,
                ),
                title: Text(
                  "SALADES",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                subtitle: Text(
                  "Vous trouverez tous les recettes de salades içi !",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SaladePage(),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Theme.of(context).colorScheme.secondary,
            child: ListTile(
              leading: Image.asset(
                'lib/images/gateau.jpg',
                width: 220,
                height: 220,
              ),
              title: Text(
                "GATEAUX",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              subtitle: Text(
                "Vous trouverez tous les recettes de gateaux içi !",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GateauPage(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Theme.of(context).colorScheme.secondary,
            child: ListTile(
              leading: Image.asset(
                'lib/images/jus.jpg',
                width: 220,
                height: 220,
              ),
              title: Text(
                "JUS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              subtitle: Text(
                "Vous trouverez tous les recettes des jus içi !",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const JusPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}