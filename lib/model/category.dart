/**
 * class CategoryModel {
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

 */


/**
 * json_to_dart的使用

    如果我们得到一个特别复杂的JSON,有时候会无从下手开始写Model,这时候就可以使用一些辅助工具。我认为json_to_dart是比较好用的一个。它可以直接把json转换成dart类，然后进行一定的修改，就可以快乐的使用了。工作中我拿到一个json，都是先操作一下，然后再改的。算是一个小窍门吧。

    请记住网址：

    https://javiercbk.github.io/json_to_dart/
 */

//使用自动生产的model
class CategoryModel {
  String code;
  String message;
  List<Data> data;

  CategoryModel({this.code, this.message, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String mallCategoryId;
  String mallCategoryName;
  List<BxMallSubDto> bxMallSubDto;
  Null comments;
  String image;

  Data(
      {this.mallCategoryId,
        this.mallCategoryName,
        this.bxMallSubDto,
        this.comments,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    mallCategoryId = json['mallCategoryId'];
    mallCategoryName = json['mallCategoryName'];
    if (json['bxMallSubDto'] != null) {
      bxMallSubDto = new List<BxMallSubDto>();
      json['bxMallSubDto'].forEach((v) {
        bxMallSubDto.add(new BxMallSubDto.fromJson(v));
      });
    }
    comments = json['comments'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallCategoryName'] = this.mallCategoryName;
    if (this.bxMallSubDto != null) {
      data['bxMallSubDto'] = this.bxMallSubDto.map((v) => v.toJson()).toList();
    }
    data['comments'] = this.comments;
    data['image'] = this.image;
    return data;
  }
}

class BxMallSubDto {
  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  String comments;

  BxMallSubDto(
      {this.mallSubId, this.mallCategoryId, this.mallSubName, this.comments});

  BxMallSubDto.fromJson(Map<String, dynamic> json) {
    mallSubId = json['mallSubId'];
    mallCategoryId = json['mallCategoryId'];
    mallSubName = json['mallSubName'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallSubId'] = this.mallSubId;
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallSubName'] = this.mallSubName;
    data['comments'] = this.comments;
    return data;
  }
}