class SaveRecipeList {
  String? recipeID;
  String? recipeName;
  List<String>? category;
  String? method;
  int? cookingTime;
  String? image;
  int? colorie;
  UsernameID? usernameID;

  SaveRecipeList(
      {this.recipeID,
      this.recipeName,
      this.category,
      this.method,
      this.cookingTime,
      this.image,
      this.colorie,
      this.usernameID});

  SaveRecipeList.fromJson(Map<String, dynamic> json) {
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
    interest = json['Interest'].cast<String>();
    allogre = json['Allogre'].cast<String>();
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
