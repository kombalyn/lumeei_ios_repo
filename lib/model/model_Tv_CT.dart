// ignore_for_file: unnecessary_this, file_names

class CategoriesTV {
  int? cid;
  String? categoryName;
  String? categoryImage;

  CategoriesTV({this.cid, this.categoryName, this.categoryImage});

  CategoriesTV.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cid'] = this.cid;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    return data;
  }
}
