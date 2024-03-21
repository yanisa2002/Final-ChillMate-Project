class Menu {
  Recipe? recipe;
  num? rate;

  Menu({this.rate, this.recipe});

  Menu.fromJson(Map<String, dynamic> json) {
    recipe =
        json['recipe'] != null ? new Recipe.fromJson(json['recipe']) : null;
    rate = json['rate'];
  }
}

class Recipe {
  String? recipeID;
  String? recipeName;
  List<String>? category;
  String? method;
  int? cookingTime;
  String? image;
  num? colorie;
  UsernameID? usernameID;
  List<Ingredients>? ingredients;
  List<String>? ratings;

  Recipe(
      {this.recipeID,
      this.recipeName,
      this.category,
      this.method,
      this.cookingTime,
      this.image,
      this.colorie,
      this.usernameID,
      this.ingredients,
      this.ratings});

  Recipe.fromJson(Map<String, dynamic> json) {
    recipeID = json['Recipe_ID'];
    recipeName = json['Recipe_name'];
    category = json['Category'].cast<String>();
    method = json['Method'];
    cookingTime = json['CookingTime'];
    image = json['Image'];
    colorie = json['Colorie'];
    usernameID = json['Username_ID'] != null
        ? new UsernameID.fromJson(json['Username_ID'])
        : null;
    if (json['Ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['Ingredients'].forEach((v) {
        ingredients!.add(new Ingredients.fromJson(v));
      });
    }
    ratings = json['Ratings'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Recipe_ID'] = this.recipeID;
    data['Recipe_name'] = this.recipeName;
    data['Category'] = this.category;
    data['Method'] = this.method;
    data['CookingTime'] = this.cookingTime;
    data['Image'] = this.image;
    data['Colorie'] = this.colorie;
    if (this.usernameID != null) {
      data['Username_ID'] = this.usernameID!.toJson();
    }
    if (this.ingredients != null) {
      data['Ingredients'] = this.ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UsernameID {
  String? userID;
  String? userName;
  String? name;
  String? email;
  String? password;
  String? image;
  String? timeAT;
  List<String>? interest;
  List<String>? allogre;
  int? role;

  UsernameID(
      {this.userID,
      this.userName,
      this.name,
      this.email,
      this.password,
      this.image,
      this.timeAT,
      this.interest,
      this.allogre,
      this.role});

  UsernameID.fromJson(Map<String, dynamic> json) {
    userID = json['User_ID'];
    userName = json['UserName'];
    name = json['Name'];
    email = json['Email'];
    password = json['Password'];
    image = json['Image'];
    timeAT = json['TimeAT'];
    interest = json['Interest'] == null
        ? []
        : List<String>.from(json['Interest'].map((x) => x) ?? []);
    allogre = json['Allogre'] == null
        ? []
        : List<String>.from(json['Allogre'].map((x) => x) ?? []);
    role = json['Role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User_ID'] = this.userID;
    data['UserName'] = this.userName;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['Image'] = this.image;
    data['TimeAT'] = this.timeAT;
    data['Interest'] = this.interest;
    data['Allogre'] = this.allogre;
    data['Role'] = this.role;
    return data;
  }
}

class Ingredients {
  String? ingredientsID;
  num? amount;
  RawMaterial? rawMaterial;

  Ingredients({this.ingredientsID, this.amount, this.rawMaterial});

  Ingredients.fromJson(Map<String, dynamic> json) {
    ingredientsID = json['Ingredients_ID'];
    amount = json['Amount'];
    rawMaterial = json['Raw_material'] != null
        ? new RawMaterial.fromJson(json['Raw_material'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Ingredients_ID'] = this.ingredientsID;
    data['Amount'] = this.amount;
    if (this.rawMaterial != null) {
      data['Raw_material'] = this.rawMaterial!.toJson();
    }
    return data;
  }
}

class RawMaterial {
  String? rawMaterialID;
  num? amount;
  String? nameing;

  RawMaterial({this.rawMaterialID, this.amount, this.nameing});

  RawMaterial.fromJson(Map<String, dynamic> json) {
    rawMaterialID = json['Raw_material_ID'];
    amount = json['Amount'];
    nameing = json['Nameing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Raw_material_ID'] = this.rawMaterialID;
    data['Amount'] = this.amount;
    data['Nameing'] = this.nameing;
    return data;
  }
}
