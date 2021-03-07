class RecipeGPTRequest {
  var direction = [];
  List<String> ingredient = <String>[];
  List<String> title = <String>[]; // Length 1
  int top_k = 3; // No idea

  RecipeGPTRequest({this.direction, this.ingredient, this.title, this.top_k});

  RecipeGPTRequest.fromJson(Map<String, dynamic> json) {
    direction = json['direction'] as List;
    ingredient = json['ingredient'] as List<String>;
    title = json['title'] as List<String>;
    top_k = json['top_k'] as int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['direction'] = direction;
    data['ingredient'] = ingredient;
    data['title'] = title;
    data['top_k'] = top_k;
    return data;
  }
}

class RecipeGPTResponse {
  // Ditching the tokens in the "highlight" bit
  String prompt;

  RecipeGPTResponse({this.prompt});

  RecipeGPTResponse.fromJson(Map<String, dynamic> json) {
    prompt = json['prompt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prompt'] = prompt;
    return data;
  }
}
