import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/user/other/user_recipe_details/user_recipes_description.dart';
import 'package:recipizz/pages/user/other/user_recipe_details/user_recipes_details.dart';
import 'package:recipizz/pages/user/other/user_recipe_details/user_recipes_direction.dart';
import 'package:recipizz/pages/user/other/user_recipe_details/user_recipe_ingredients.dart';
import 'package:recipizz/services/database/hive/favorite/favorite_model.dart';
import 'package:recipizz/services/database/hive/hive_open_box.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserRecipeDetailDesktop extends StatefulWidget {
  final String? recipeId;
  const UserRecipeDetailDesktop({super.key, this.recipeId});

  @override
  State<UserRecipeDetailDesktop> createState() =>
      _UserRecipeDetailDesktop();
}

class _UserRecipeDetailDesktop extends State<UserRecipeDetailDesktop> {
  ValueNotifier<List<String>> iconListNotifier =
      ValueNotifier<List<String>>([]);
  List<String> iconList = [];
  late DocumentReference _recipeReferance;
  late Future<DocumentSnapshot> _recipeFutureData;
  late bool favoriteIcon;
  var recipes = favoriteBox.values.toList().cast<FavoriteModel>();

  void getIconList() {
    for (int i = 0; i < recipes.length; i++) {
      iconList.add(recipes[i].id.toString());
    }
    iconListNotifier.value = iconList;
  }

  @override
  void initState() {
    getIconList();
    _recipeReferance =
        FirebaseFirestore.instance.collection('recipes').doc(widget.recipeId);
    _recipeFutureData = _recipeReferance.get();
    favoriteIcon = (iconList.contains(widget.recipeId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.colors.shadecolor,
          foregroundColor: AppTheme.colors.appWhiteColor,
          title: Text('Recipes',
              style: TextStyle(fontFamily: AppTheme.fonts.jost)),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
              )),
        ),
        body: FutureBuilder(
            future: _recipeFutureData,
            builder: (BuildContext context, AsyncSnapshot snapShot) {
              if (snapShot.hasData) {
                DocumentSnapshot recipeDocSnapShot = snapShot.data;
                Map recipeData = recipeDocSnapShot.data() as Map;
                return Row(
                  children: [
                    SingleChildScrollView(
                      child: SizedBox(
                        width: screenWidth / 2,
                        child: Column(
                          children: [
                            //recipe details
                            UserRecipeDetail(
                              recipeId: widget.recipeId,
                              recipename: recipeData['name'],
                              recipeImage: recipeData['recipeImage'],
                              duration: recipeData['timeRequired'],
                              serving: recipeData['serving'],
                              favoriteIcon: favoriteIcon,
                            ),
                            UserRecipeDirection(
                                recipesDirection: recipeData['directions'],
                                timeRequired: recipeData['timeRequired']),
                            //ingredients
                          ],
                        ),
                      ),
                    ),
//directions
                    SingleChildScrollView(
                      child: SizedBox(
                        width: screenWidth / 2,
                        child: Column(
                          children: [
                            UserRecipesIngredients(
                                ingredientsItems: recipeData['ingredient']),

                            //description
                            UserRecipeDescription(
                                description: recipeData['description'])
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
