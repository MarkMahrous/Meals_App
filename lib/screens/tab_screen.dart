import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/drawer.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

// final kInitialFilters = {
//   Filter.glutenFree: false,
//   Filter.lactoseFree: false,
//   Filter.vegan: false,
//   Filter.vegetarian: false,
// };

// why I can't just do this?

// List<int> numbers = [1, 2, 3];

// void addNumber(int number) {
//   numbers.add(number);
// }

// List<Meal> favoriteMeals = [];

// void toggleMealFavoriteStatus(Meal meal) {
//   if (favoriteMeals.contains(meal)) {
//     favoriteMeals.remove(meal);
//   } else {
//     favoriteMeals.add(meal);
//   }
// }

// if it's stateless widget, we use ConsumerWidget
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int currentIndex = 0;

  void _selectScreen(index) {
    currentIndex = index;
    if (index == 0) {
      setState(() {
        currentIndex = 0;
      });
    } else {
      setState(() {
        currentIndex = 1;
      });
    }
  }

  void _setScreen(String indentifier) async {
    Navigator.of(context).pop();
    if (indentifier == 'Filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final filters = ref.watch(filterProvider);
    List<Meal> availableMeals = meals.where((meal) {
      if (filters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (filters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (filters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    final favoriteMeals = ref.watch(favoriteMealsProvider);

    Widget activeScreen = currentIndex == 0
        ? CategoriesScreen(
            availableMeals: availableMeals,
          )
        : MealsScreen(meals: favoriteMeals);

    return Scaffold(
      appBar: AppBar(
        title: currentIndex == 0
            ? const Text("Categories")
            : const Text("Favorites"),
      ),
      drawer: MainDrawer(setScreen: _setScreen),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
