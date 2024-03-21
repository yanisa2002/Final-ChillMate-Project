import 'dart:convert';

import 'package:chillmate/models/fridge.dart';
import 'package:chillmate/data/secure_storage.dart';
import 'package:chillmate/models/raw.dart';
import 'package:chillmate/models/recipe.dart';
import 'package:chillmate/models/saveRecipe.dart';
import 'package:chillmate/models/userData.dart';
import 'package:http/http.dart';

class Repository {
  String uri = 'http://161.246.5.159:7504';

  Future<List<Fridge>> getData() async {
    String token = await SecureStorage().readSecureData('token');
    print("homeeeeeee");
    var headers = {'Authorization': 'Bearer ${token}'};

    print(headers);
    print('start');
    var response = await get(Uri.parse(uri + '/user/fridge'), headers: headers);

    print("----");
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      List<Fridge> dataProfile =
          List<Fridge>.from(responseBody.map((x) => Fridge.fromJson(x)));
      return dataProfile;
    } else {
      print(response);
      return [];
    }
  }

  Future<User?> getProfile() async {
    try {
      String token = await SecureStorage().readSecureData('token');
      var headers = {'Authorization': 'Bearer ${token}'};
      var response = await get(Uri.parse(uri + '/user'), headers: headers);

      if (response.statusCode == 200) {
        print(response.body);
        final responseBody = jsonDecode(response.body);

        User dataProfile = User.fromJson(responseBody);
        return dataProfile;
      } else {
        print(response);
        print('-------------------------------');
      }
    } catch (e) {
      print('result');
      print(e.toString());
    }
  }

  Future<List<Ingre>> getRaw() async {
    String token = await SecureStorage().readSecureData('token');
    var headers = {'Authorization': 'Bearer ${token}'};
    var response = await get(Uri.parse(uri + '/raw'), headers: headers);
    print("--getRaw--");
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      final responseBody = jsonDecode(response.body);

      List<Ingre> dataRaw =
          List<Ingre>.from(responseBody.map((x) => Ingre.fromJson(x)));
      return dataRaw;
    } else {
      print(response);
      return [];
    }
  }

  Future<List<Menu>> getRecipes() async {
    String token = await SecureStorage().readSecureData('token');
    print("Recipeeeee");
    var headers = {'Authorization': 'Bearer ${token}'};

    print(headers);
    print('start');
    var response =
        await get(Uri.parse(uri + '/recipe/recommen'), headers: headers);

    print("----");
    print(response.statusCode);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      List<Menu> dataRecipe =
          List<Menu>.from(responseBody.map((x) => Menu.fromJson(x)));
      return dataRecipe;
    } else {
      print("error");
      print(response);
      return [];
    }
  }

  Future<List<Menu>> getRecipeAll() async {
    String token = await SecureStorage().readSecureData('token');
    print("Recipeeeee");
    var headers = {'Authorization': 'Bearer ${token}'};

    print(headers);
    print('start');
    var response = await get(Uri.parse(uri + '/recipe'), headers: headers);

    print("----");
    print(response.statusCode);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      List<Menu> dataRecipe =
          List<Menu>.from(responseBody.map((x) => Menu.fromJson(x)));
      return dataRecipe;
    } else {
      print("error");
      print(response);
      return [];
    }
  }

  Future<List<SaveRecipeList>> getSaveRecipe() async {
    String token = await SecureStorage().readSecureData('token');
    print("Recipeeeee");
    var headers = {'Authorization': 'Bearer ${token}'};
    print('start');
    var response = await get(Uri.parse(uri + '/recipe/save'), headers: headers);

    print("----SaveRecipe");
    print(response.statusCode);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      List<SaveRecipeList> dataGroupFridge = List<SaveRecipeList>.from(
          responseBody.map((x) => SaveRecipeList.fromJson(x)));
      return dataGroupFridge;
    } else {
      print("error");
      print(response);
      return [];
    }
  }

  Future<List<Menu>> getSearch(String id) async {
    String token = await SecureStorage().readSecureData('token');
    print("Search");
    var headers = {'Authorization': 'Bearer ${token}'};
    print('start');
    var response = await get(Uri.parse(uri + '/recipe/search?searching=' + id),
        headers: headers);
    print("----Search");
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      List<Menu> dataSearch =
          List<Menu>.from(responseBody.map((x) => Menu.fromJson(x)));
      return dataSearch;
    } else {
      print("error");
      print(response);
      return [];
    }
  }
}
