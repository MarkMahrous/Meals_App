import 'package:flutter/material.dart';
import 'package:meals_app/widgets/filter_option.dart';
// import 'package:meals_app/screens/tab_screen.dart';
// import 'package:meals_app/widgets/drawer.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  final _isGlutenFree = false;

  final _isLactoseFree = false;

  final _isVegetarian = false;

  final _isVegan = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   setScreen: (indentifier) {
      //     Navigator.of(context).pop();
      //     if (indentifier == 'Meals') {
      //       Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: Column(
        children: [
          FilterOption(
            value: _isGlutenFree,
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
          ),
          FilterOption(
            value: _isLactoseFree,
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
          ),
          FilterOption(
            value: _isVegetarian,
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
          ),
          FilterOption(
            value: _isVegan,
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
          ),
        ],
      ),
    );
  }
}
