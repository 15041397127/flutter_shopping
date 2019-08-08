class CategoryModel {
  String mallCategoryId; //类别编号
  String mallCategoryName; //类别名称
  List<dynamic> bxMallSubDto; //
  Null comments;
  String image;

  CategoryModel(
      {this.mallCategoryId,
      this.mallCategoryName,
      this.bxMallSubDto,
      this.comments,
      this.image});

  //工厂模式构造方法 类似多肽 类似静态方法
  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
      bxMallSubDto: json['bxMallSubDto'],
      comments: json['comments'],
      image: json['image'],
    );
  }
}

////列表model
class CategoryListModel{

  List<CategoryModel>data;

  CategoryListModel(this.data);

  factory CategoryListModel.fromJson(List json){

    return CategoryListModel(
        json.map((i) => CategoryModel.fromJson((i))).toList()
    );
  }
}
