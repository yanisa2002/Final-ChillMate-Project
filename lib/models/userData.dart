import 'package:chillmate/models/recipe.dart';

class User {
  User({
    required this.userID,
    required this.userName,
    required this.name,
    required this.email,
    required this.password,
    required this.image,
    required this.timeAT,
    required this.interest,
    required this.allogre,
    required this.role,
    required this.follows,
    required this.followers,
    required this.postRecipes,
    required this.saves,
  });
  late final String userID;
  late final String userName;
  late final String name;
  late final String email;
  late final String password;
  late final String image;
  late final String timeAT;
  late final List<String> interest;
  late final List<String> allogre;
  late final int role;
  late final List<Follow> follows;
  late final List<Follow> followers;
  late final List<Recipe> postRecipes;
  late final List<Recipe> saves;

  User.fromJson(Map<String, dynamic> json) {
    userID = json['User_ID'];
    userName = json['UserName'];
    name = json['Name'];
    email = json['Email'];
    password = json['Password'];
    image = json['Image'];
    timeAT = json['TimeAT'];
    interest = json["Interest"] == null
        ? []
        : List.castFrom<dynamic, String>(json['Interest']);
    allogre = json["Allogre"] == null
        ? []
        : List.castFrom<dynamic, String>(json['Allogre']);
    role = json['Role'];
    follows = List.from(json['Follow']).map((e) => Follow.fromJson(e)).toList();
    followers =
        List.from(json['Follower']).map((e) => Follow.fromJson(e)).toList();
    postRecipes =
        List.from(json['PostRecipe']).map((e) => Recipe.fromJson(e)).toList();
    saves = List.from(json['Save']).map((e) => Recipe.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['User_ID'] = userID;
    _data['UserName'] = userName;
    _data['Name'] = name;
    _data['Email'] = email;
    _data['Password'] = password;
    _data['Image'] = image;
    _data['TimeAT'] = timeAT;
    _data['Interest'] = interest;
    _data['Allogre'] = allogre;
    _data['Role'] = role;
    _data['Follow'] = follows.map((e) => e.toJson()).toList();
    _data['Follower'] = followers.map((e) => e.toJson()).toList();
    _data['PostRecipe'] = postRecipes.map((e) => e.toJson()).toList();
    _data['Save'] = saves.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Follow {
  Follow({
    required this.followID,
  });
  late final String followID;

  Follow.fromJson(Map<String, dynamic> json) {
    followID = json['Follow_ID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Follow_ID'] = followID;
    return _data;
  }
}
