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


/**
 * json_to_dart的使用

    如果我们得到一个特别复杂的JSON,有时候会无从下手开始写Model,这时候就可以使用一些辅助工具。我认为json_to_dart是比较好用的一个。它可以直接把json转换成dart类，然后进行一定的修改，就可以快乐的使用了。工作中我拿到一个json，都是先操作一下，然后再改的。算是一个小窍门吧。

    请记住网址：

    https://javiercbk.github.io/json_to_dart/
 */
