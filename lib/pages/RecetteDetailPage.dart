import 'package:flutter/material.dart';
import '../services/Category.dart';
import '../services/Recette.dart';
import '../services/MenuService.dart';

class RecetteDetailPage extends StatefulWidget {
  final Recette recette;

  const RecetteDetailPage({Key? key, required this.recette}) : super(key: key);

  @override
  _RecetteDetailPageState createState() => _RecetteDetailPageState();
}

class _RecetteDetailPageState extends State<RecetteDetailPage> {
  final MenuService _menuService = MenuService();
  final List<String> _categories = ['PLATS', 'SALADES', 'JUS', 'GATEAUX'];

  void _showEditRecetteDialog(Recette recette) {
    String name = recette.name;
    String description = recette.description;
    String? selectedCategory = recette.category;

    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder<List<Category>>(
          future: _menuService.getCategories().first,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final categories = snapshot.data!;
              return AlertDialog(
                title: Text('Edit Recette'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Name'),
                      controller: TextEditingController(text: name),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Description'),
                      controller: TextEditingController(text: description),
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Category'),
                      value: selectedCategory,
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category.name,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (selectedCategory != null) {
                        _menuService.updateRecette(Recette(
                          id: recette.id,
                          name: name,
                          description: description,
                          category: selectedCategory!,
                          imagePath: recette.imagePath,
                        ));
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Recette>(
      stream: _menuService.getRecetteById(widget.recette.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final recette = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(recette.name),
              actions: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showEditRecetteDialog(recette);
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.asset(recette.imagePath, height: 250, width: double.infinity, fit: BoxFit.cover),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          child: Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              recette.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Category : ${recette.category}',
                      style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Description :',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recette.description,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}