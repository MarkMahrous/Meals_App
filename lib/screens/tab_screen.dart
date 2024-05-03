import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/drawer.dart';

final kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int currentIndex = 0;
  List<Meal> favoriteMeals = [];
  Map<Filter, bool> filters = kInitialFilters;

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

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    if (favoriteMeals.contains(meal)) {
      setState(() {
        favoriteMeals.remove(meal);
        _showMessage("Removed from favorites!");
      });
    } else {
      setState(() {
        favoriteMeals.add(meal);
        _showMessage("Added to favorites!");
      });
    }
  }

  void _setScreen(String indentifier) async {
    Navigator.of(context).pop();
    if (indentifier == 'Filters') {
      final results = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(filters: filters),
        ),
      );
      setState(() {
        filters = results ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Meal> availableMeals = dummyMeals.where((meal) {
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

    Widget activeScreen = currentIndex == 0
        ? CategoriesScreen(
            onToggleFavorite: _toggleMealFavoriteStatus,
            availableMeals: availableMeals,
          )
        : MealsScreen(
            meals: favoriteMeals, onToggleFavorite: _toggleMealFavoriteStatus);

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
