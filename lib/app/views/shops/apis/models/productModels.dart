import 'dart:convert';
/// id : 1
/// category_id : 1
/// name : "Sub Category 1"
/// status : "1"
/// priority : "normal"
/// created_at : "2023-03-02T05:06:12.000000Z"
/// updated_at : "2023-03-02T05:06:12.000000Z"
/// products : [{"id":18,"user_id":43,"module_id":1,"store_id":1,"category_id":1,"subCategory_id":1,"addon_id":1,"attribute_id":14,"unit_id":1,"lib_product_id":3,"name":"patanjali atta","variantDetails":"[{\"type\":\"1\",\"price\":\"60\",\"stock\":\"100\",\"discountType\":\"percent\",\"discount\":\"10\"},{\"type\":\"5\",\"price\":\"270\",\"stock\":\"60\",\"discountType\":\"amount\",\"discount\":\"10\"},{\"type\":\"10\",\"price\":\"480\",\"stock\":\"30\",\"discountType\":\"percent\",\"discount\":\"11110\"}]","description":"patanjali atta","image":"1683965366-645f45b6630bb.png","stock":"100","price":null,"discountType":null,"discount":null,"tag":"atta, patanjali","startTime":"02:39:00","endTime":"19:44:00","status":"1","created_at":"2023-05-15T00:41:43.000000Z","updated_at":"2023-05-15T00:41:43.000000Z","image_url":"$baseurl/public/storage/image/1683965366-645f45b6630bb.png","store":{"id":1,"user_id":43,"zone_id":1,"module_id":1,"name":"Store 1","phone":"4545454545","email":"store1@gmail.com","address":"rajkot","tax":"10","minTime":"10","maxTime":"10","timeType":"hours","logo":"1677753316-64007be4b0fb4.png","cover":"1680960615-64316c67b0278.png","latitude":"25.749654223123247","longitude":"82.65700995588377","status":"1","created_at":"2023-03-02T05:04:24.000000Z","updated_at":"2023-04-08T08:00:15.000000Z","logo_url":"$baseurl/public/storage/image/1677753316-64007be4b0fb4.png","cover_url":"$baseurl/public/storage/image/1680960615-64316c67b0278.png"},"category":{"id":1,"user_id":1,"module_id":1,"cate_by":"admin","name":"Atta, Rice","status":"1","priority":"high","image":"1681204606-6435257ecd62f.png","created_at":"2023-03-02T05:05:38.000000Z","updated_at":"2023-04-11T09:17:15.000000Z","image_url":"$baseurl/public/storage/image/1681204606-6435257ecd62f.png"},"sub_category":{"id":1,"category_id":1,"name":"Sub Category 1","status":"1","priority":"normal","created_at":"2023-03-02T05:06:12.000000Z","updated_at":"2023-03-02T05:06:12.000000Z"},"module":{"id":1,"user_id":1,"name":"module 1","type":"Grocery","description":"<p>module 1</p>","status":"1","theme":"1","icon":"1677753166-64007b4e00695.png","thumbnail":"1677753166-64007b4e1163c.png","created_at":"2023-03-02T05:02:46.000000Z","updated_at":"2023-03-09T06:44:32.000000Z","thumbnail_url":"$baseurl/public/storage/image/1677753166-64007b4e1163c.png","icon_url":"$baseurl/public/storage/image/1677753166-64007b4e00695.png"},"addon":{"id":1,"name":"Addon 1","insert_by":"admin","store_id":0,"created_at":"2023-03-02T04:47:29.000000Z","updated_at":"2023-03-02T04:54:13.000000Z"},"attribute":{"id":14,"name":"weight","created_at":"2023-04-11T09:23:52.000000Z","updated_at":"2023-04-11T09:23:52.000000Z"},"unit":{"id":1,"name":"kg","created_at":"2023-03-02T04:37:27.000000Z","updated_at":"2023-04-11T09:22:13.000000Z"}},{"id":19,"user_id":43,"module_id":1,"store_id":1,"category_id":1,"subCategory_id":1,"addon_id":12,"attribute_id":14,"unit_id":1,"lib_product_id":3,"name":"patanjali atta","variantDetails":"[{\"type\":\"1\",\"price\":\"60\",\"stock\":\"100\",\"discountType\":\"percent\",\"discount\":\"10\"},{\"type\":\"5\",\"price\":\"270\",\"stock\":\"10\",\"discountType\":\"amount\",\"discount\":\"10\"},{\"type\":\"10\",\"price\":\"480\",\"stock\":\"30\",\"discountType\":\"percent\",\"discount\":\"11110\"}]","description":"patanjali atta","image":"1683965366-645f45b6630bb.png","stock":"100","price":null,"discountType":null,"discount":null,"tag":"atta, patanjali","startTime":"02:39:00","endTime":"19:44:00","status":"1","created_at":"2023-05-15T01:13:32.000000Z","updated_at":"2023-05-15T01:13:32.000000Z","image_url":"$baseurl/public/storage/image/1683965366-645f45b6630bb.png","store":{"id":1,"user_id":43,"zone_id":1,"module_id":1,"name":"Store 1","phone":"4545454545","email":"store1@gmail.com","address":"rajkot","tax":"10","minTime":"10","maxTime":"10","timeType":"hours","logo":"1677753316-64007be4b0fb4.png","cover":"1680960615-64316c67b0278.png","latitude":"25.749654223123247","longitude":"82.65700995588377","status":"1","created_at":"2023-03-02T05:04:24.000000Z","updated_at":"2023-04-08T08:00:15.000000Z","logo_url":"$baseurl/public/storage/image/1677753316-64007be4b0fb4.png","cover_url":"$baseurl/public/storage/image/1680960615-64316c67b0278.png"},"category":{"id":1,"user_id":1,"module_id":1,"cate_by":"admin","name":"Atta, Rice","status":"1","priority":"high","image":"1681204606-6435257ecd62f.png","created_at":"2023-03-02T05:05:38.000000Z","updated_at":"2023-04-11T09:17:15.000000Z","image_url":"$baseurl/public/storage/image/1681204606-6435257ecd62f.png"},"sub_category":{"id":1,"category_id":1,"name":"Sub Category 1","status":"1","priority":"normal","created_at":"2023-03-02T05:06:12.000000Z","updated_at":"2023-03-02T05:06:12.000000Z"},"module":{"id":1,"user_id":1,"name":"module 1","type":"Grocery","description":"<p>module 1</p>","status":"1","theme":"1","icon":"1677753166-64007b4e00695.png","thumbnail":"1677753166-64007b4e1163c.png","created_at":"2023-03-02T05:02:46.000000Z","updated_at":"2023-03-09T06:44:32.000000Z","thumbnail_url":"$baseurl/public/storage/image/1677753166-64007b4e1163c.png","icon_url":"$baseurl/public/storage/image/1677753166-64007b4e00695.png"},"addon":{"id":12,"name":"Store Addon 3","insert_by":"store","store_id":4,"created_at":"2023-04-18T01:22:01.000000Z","updated_at":"2023-04-18T01:22:01.000000Z"},"attribute":{"id":14,"name":"weight","created_at":"2023-04-11T09:23:52.000000Z","updated_at":"2023-04-11T09:23:52.000000Z"},"unit":{"id":1,"name":"kg","created_at":"2023-03-02T04:37:27.000000Z","updated_at":"2023-04-11T09:22:13.000000Z"}}]

ProductModels productModelsFromJson(String str) => ProductModels.fromJson(json.decode(str));
String productModelsToJson(ProductModels data) => json.encode(data.toJson());
class ProductModels {
  ProductModels({
      num? id, 
      num? categoryId, 
      String? name, 
      String? status, 
      String? priority, 
      String? createdAt, 
      String? updatedAt, 
      List<Products>? products,}){
    _id = id;
    _categoryId = categoryId;
    _name = name;
    _status = status;
    _priority = priority;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _products = products;
}

  ProductModels.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _name = json['name'];
    _status = json['status'];
    _priority = json['priority'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }
  num? _id;
  num? _categoryId;
  String? _name;
  String? _status;
  String? _priority;
  String? _createdAt;
  String? _updatedAt;
  List<Products>? _products;
ProductModels copyWith({  num? id,
  num? categoryId,
  String? name,
  String? status,
  String? priority,
  String? createdAt,
  String? updatedAt,
  List<Products>? products,
}) => ProductModels(  id: id ?? _id,
  categoryId: categoryId ?? _categoryId,
  name: name ?? _name,
  status: status ?? _status,
  priority: priority ?? _priority,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  products: products ?? _products,
);
  num? get id => _id;
  num? get categoryId => _categoryId;
  String? get name => _name;
  String? get status => _status;
  String? get priority => _priority;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Products>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['name'] = _name;
    map['status'] = _status;
    map['priority'] = _priority;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 18
/// user_id : 43
/// module_id : 1
/// store_id : 1
/// category_id : 1
/// subCategory_id : 1
/// addon_id : 1
/// attribute_id : 14
/// unit_id : 1
/// lib_product_id : 3
/// name : "patanjali atta"
/// variantDetails : "[{\"type\":\"1\",\"price\":\"60\",\"stock\":\"100\",\"discountType\":\"percent\",\"discount\":\"10\"},{\"type\":\"5\",\"price\":\"270\",\"stock\":\"60\",\"discountType\":\"amount\",\"discount\":\"10\"},{\"type\":\"10\",\"price\":\"480\",\"stock\":\"30\",\"discountType\":\"percent\",\"discount\":\"11110\"}]"
/// description : "patanjali atta"
/// image : "1683965366-645f45b6630bb.png"
/// stock : "100"
/// price : null
/// discountType : null
/// discount : null
/// tag : "atta, patanjali"
/// startTime : "02:39:00"
/// endTime : "19:44:00"
/// status : "1"
/// created_at : "2023-05-15T00:41:43.000000Z"
/// updated_at : "2023-05-15T00:41:43.000000Z"
/// image_url : "$baseurl/public/storage/image/1683965366-645f45b6630bb.png"
/// store : {"id":1,"user_id":43,"zone_id":1,"module_id":1,"name":"Store 1","phone":"4545454545","email":"store1@gmail.com","address":"rajkot","tax":"10","minTime":"10","maxTime":"10","timeType":"hours","logo":"1677753316-64007be4b0fb4.png","cover":"1680960615-64316c67b0278.png","latitude":"25.749654223123247","longitude":"82.65700995588377","status":"1","created_at":"2023-03-02T05:04:24.000000Z","updated_at":"2023-04-08T08:00:15.000000Z","logo_url":"$baseurl/public/storage/image/1677753316-64007be4b0fb4.png","cover_url":"$baseurl/public/storage/image/1680960615-64316c67b0278.png"}
/// category : {"id":1,"user_id":1,"module_id":1,"cate_by":"admin","name":"Atta, Rice","status":"1","priority":"high","image":"1681204606-6435257ecd62f.png","created_at":"2023-03-02T05:05:38.000000Z","updated_at":"2023-04-11T09:17:15.000000Z","image_url":"$baseurl/public/storage/image/1681204606-6435257ecd62f.png"}
/// sub_category : {"id":1,"category_id":1,"name":"Sub Category 1","status":"1","priority":"normal","created_at":"2023-03-02T05:06:12.000000Z","updated_at":"2023-03-02T05:06:12.000000Z"}
/// module : {"id":1,"user_id":1,"name":"module 1","type":"Grocery","description":"<p>module 1</p>","status":"1","theme":"1","icon":"1677753166-64007b4e00695.png","thumbnail":"1677753166-64007b4e1163c.png","created_at":"2023-03-02T05:02:46.000000Z","updated_at":"2023-03-09T06:44:32.000000Z","thumbnail_url":"$baseurl/public/storage/image/1677753166-64007b4e1163c.png","icon_url":"$baseurl/public/storage/image/1677753166-64007b4e00695.png"}
/// addon : {"id":1,"name":"Addon 1","insert_by":"admin","store_id":0,"created_at":"2023-03-02T04:47:29.000000Z","updated_at":"2023-03-02T04:54:13.000000Z"}
/// attribute : {"id":14,"name":"weight","created_at":"2023-04-11T09:23:52.000000Z","updated_at":"2023-04-11T09:23:52.000000Z"}
/// unit : {"id":1,"name":"kg","created_at":"2023-03-02T04:37:27.000000Z","updated_at":"2023-04-11T09:22:13.000000Z"}

Products productsFromJson(String str) => Products.fromJson(json.decode(str));
String productsToJson(Products data) => json.encode(data.toJson());
class Products {
  Products({
      num? id, 
      num? userId, 
      num? moduleId, 
      num? storeId, 
      num? categoryId, 
      num? subCategoryId, 
      num? addonId, 
      num? attributeId, 
      num? unitId, 
      num? libProductId, 
      String? name, 
      String? variantDetails, 
      String? description, 
      String? image, 
      String? stock, 
      dynamic price, 
      dynamic discountType, 
      dynamic discount, 
      String? tag, 
      String? startTime, 
      String? endTime, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? imageUrl, 
      Store? store, 
      Category? category, 
      SubCategory? subCategory, 
      Module? module, 
      Addon? addon, 
      Attribute? attribute, 
      Unit? unit,}){
    _id = id;
    _userId = userId;
    _moduleId = moduleId;
    _storeId = storeId;
    _categoryId = categoryId;
    _subCategoryId = subCategoryId;
    _addonId = addonId;
    _attributeId = attributeId;
    _unitId = unitId;
    _libProductId = libProductId;
    _name = name;
    _variantDetails = variantDetails;
    _description = description;
    _image = image;
    _stock = stock;
    _price = price;
    _discountType = discountType;
    _discount = discount;
    _tag = tag;
    _startTime = startTime;
    _endTime = endTime;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imageUrl = imageUrl;
    _store = store;
    _category = category;
    _subCategory = subCategory;
    _module = module;
    _addon = addon;
    _attribute = attribute;
    _unit = unit;
}

  Products.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _moduleId = json['module_id'];
    _storeId = json['store_id'];
    _categoryId = json['category_id'];
    _subCategoryId = json['subCategory_id'];
    _addonId = json['addon_id'];
    _attributeId = json['attribute_id'];
    _unitId = json['unit_id'];
    _libProductId = json['lib_product_id'];
    _name = json['name'];
    _variantDetails = json['variantDetails'];
    _description = json['description'];
    _image = json['image'];
    _stock = json['stock'];
    _price = json['price'];
    _discountType = json['discountType'];
    _discount = json['discount'];
    _tag = json['tag'];
    _startTime = json['startTime'];
    _endTime = json['endTime'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imageUrl = json['image_url'];
    _store = json['store'] != null ? Store.fromJson(json['store']) : null;
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _subCategory = json['sub_category'] != null ? SubCategory.fromJson(json['sub_category']) : null;
    _module = json['module'] != null ? Module.fromJson(json['module']) : null;
    _addon = json['addon'] != null ? Addon.fromJson(json['addon']) : null;
    _attribute = json['attribute'] != null ? Attribute.fromJson(json['attribute']) : null;
    _unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
  }
  num? _id;
  num? _userId;
  num? _moduleId;
  num? _storeId;
  num? _categoryId;
  num? _subCategoryId;
  num? _addonId;
  num? _attributeId;
  num? _unitId;
  num? _libProductId;
  String? _name;
  String? _variantDetails;
  String? _description;
  String? _image;
  String? _stock;
  dynamic _price;
  dynamic _discountType;
  dynamic _discount;
  String? _tag;
  String? _startTime;
  String? _endTime;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _imageUrl;
  Store? _store;
  Category? _category;
  SubCategory? _subCategory;
  Module? _module;
  Addon? _addon;
  Attribute? _attribute;
  Unit? _unit;
Products copyWith({  num? id,
  num? userId,
  num? moduleId,
  num? storeId,
  num? categoryId,
  num? subCategoryId,
  num? addonId,
  num? attributeId,
  num? unitId,
  num? libProductId,
  String? name,
  String? variantDetails,
  String? description,
  String? image,
  String? stock,
  dynamic price,
  dynamic discountType,
  dynamic discount,
  String? tag,
  String? startTime,
  String? endTime,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? imageUrl,
  Store? store,
  Category? category,
  SubCategory? subCategory,
  Module? module,
  Addon? addon,
  Attribute? attribute,
  Unit? unit,
}) => Products(  id: id ?? _id,
  userId: userId ?? _userId,
  moduleId: moduleId ?? _moduleId,
  storeId: storeId ?? _storeId,
  categoryId: categoryId ?? _categoryId,
  subCategoryId: subCategoryId ?? _subCategoryId,
  addonId: addonId ?? _addonId,
  attributeId: attributeId ?? _attributeId,
  unitId: unitId ?? _unitId,
  libProductId: libProductId ?? _libProductId,
  name: name ?? _name,
  variantDetails: variantDetails ?? _variantDetails,
  description: description ?? _description,
  image: image ?? _image,
  stock: stock ?? _stock,
  price: price ?? _price,
  discountType: discountType ?? _discountType,
  discount: discount ?? _discount,
  tag: tag ?? _tag,
  startTime: startTime ?? _startTime,
  endTime: endTime ?? _endTime,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  imageUrl: imageUrl ?? _imageUrl,
  store: store ?? _store,
  category: category ?? _category,
  subCategory: subCategory ?? _subCategory,
  module: module ?? _module,
  addon: addon ?? _addon,
  attribute: attribute ?? _attribute,
  unit: unit ?? _unit,
);
  num? get id => _id;
  num? get userId => _userId;
  num? get moduleId => _moduleId;
  num? get storeId => _storeId;
  num? get categoryId => _categoryId;
  num? get subCategoryId => _subCategoryId;
  num? get addonId => _addonId;
  num? get attributeId => _attributeId;
  num? get unitId => _unitId;
  num? get libProductId => _libProductId;
  String? get name => _name;
  String? get variantDetails => _variantDetails;
  String? get description => _description;
  String? get image => _image;
  String? get stock => _stock;
  dynamic get price => _price;
  dynamic get discountType => _discountType;
  dynamic get discount => _discount;
  String? get tag => _tag;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get imageUrl => _imageUrl;
  Store? get store => _store;
  Category? get category => _category;
  SubCategory? get subCategory => _subCategory;
  Module? get module => _module;
  Addon? get addon => _addon;
  Attribute? get attribute => _attribute;
  Unit? get unit => _unit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['module_id'] = _moduleId;
    map['store_id'] = _storeId;
    map['category_id'] = _categoryId;
    map['subCategory_id'] = _subCategoryId;
    map['addon_id'] = _addonId;
    map['attribute_id'] = _attributeId;
    map['unit_id'] = _unitId;
    map['lib_product_id'] = _libProductId;
    map['name'] = _name;
    map['variantDetails'] = _variantDetails;
    map['description'] = _description;
    map['image'] = _image;
    map['stock'] = _stock;
    map['price'] = _price;
    map['discountType'] = _discountType;
    map['discount'] = _discount;
    map['tag'] = _tag;
    map['startTime'] = _startTime;
    map['endTime'] = _endTime;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['image_url'] = _imageUrl;
    if (_store != null) {
      map['store'] = _store?.toJson();
    }
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_subCategory != null) {
      map['sub_category'] = _subCategory?.toJson();
    }
    if (_module != null) {
      map['module'] = _module?.toJson();
    }
    if (_addon != null) {
      map['addon'] = _addon?.toJson();
    }
    if (_attribute != null) {
      map['attribute'] = _attribute?.toJson();
    }
    if (_unit != null) {
      map['unit'] = _unit?.toJson();
    }
    return map;
  }

}

/// id : 1
/// name : "kg"
/// created_at : "2023-03-02T04:37:27.000000Z"
/// updated_at : "2023-04-11T09:22:13.000000Z"

Unit unitFromJson(String str) => Unit.fromJson(json.decode(str));
String unitToJson(Unit data) => json.encode(data.toJson());
class Unit {
  Unit({
      num? id, 
      String? name, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Unit.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _createdAt;
  String? _updatedAt;
Unit copyWith({  num? id,
  String? name,
  String? createdAt,
  String? updatedAt,
}) => Unit(  id: id ?? _id,
  name: name ?? _name,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// id : 14
/// name : "weight"
/// created_at : "2023-04-11T09:23:52.000000Z"
/// updated_at : "2023-04-11T09:23:52.000000Z"

Attribute attributeFromJson(String str) => Attribute.fromJson(json.decode(str));
String attributeToJson(Attribute data) => json.encode(data.toJson());
class Attribute {
  Attribute({
      num? id, 
      String? name, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Attribute.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _createdAt;
  String? _updatedAt;
Attribute copyWith({  num? id,
  String? name,
  String? createdAt,
  String? updatedAt,
}) => Attribute(  id: id ?? _id,
  name: name ?? _name,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// id : 1
/// name : "Addon 1"
/// insert_by : "admin"
/// store_id : 0
/// created_at : "2023-03-02T04:47:29.000000Z"
/// updated_at : "2023-03-02T04:54:13.000000Z"

Addon addonFromJson(String str) => Addon.fromJson(json.decode(str));
String addonToJson(Addon data) => json.encode(data.toJson());
class Addon {
  Addon({
      num? id, 
      String? name, 
      String? insertBy, 
      num? storeId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _insertBy = insertBy;
    _storeId = storeId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Addon.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _insertBy = json['insert_by'];
    _storeId = json['store_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _insertBy;
  num? _storeId;
  String? _createdAt;
  String? _updatedAt;
Addon copyWith({  num? id,
  String? name,
  String? insertBy,
  num? storeId,
  String? createdAt,
  String? updatedAt,
}) => Addon(  id: id ?? _id,
  name: name ?? _name,
  insertBy: insertBy ?? _insertBy,
  storeId: storeId ?? _storeId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get insertBy => _insertBy;
  num? get storeId => _storeId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['insert_by'] = _insertBy;
    map['store_id'] = _storeId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// id : 1
/// user_id : 1
/// name : "module 1"
/// type : "Grocery"
/// description : "<p>module 1</p>"
/// status : "1"
/// theme : "1"
/// icon : "1677753166-64007b4e00695.png"
/// thumbnail : "1677753166-64007b4e1163c.png"
/// created_at : "2023-03-02T05:02:46.000000Z"
/// updated_at : "2023-03-09T06:44:32.000000Z"
/// thumbnail_url : "$baseurl/public/storage/image/1677753166-64007b4e1163c.png"
/// icon_url : "$baseurl/public/storage/image/1677753166-64007b4e00695.png"

Module moduleFromJson(String str) => Module.fromJson(json.decode(str));
String moduleToJson(Module data) => json.encode(data.toJson());
class Module {
  Module({
      num? id, 
      num? userId, 
      String? name, 
      String? type, 
      String? description, 
      String? status, 
      String? theme, 
      String? icon, 
      String? thumbnail, 
      String? createdAt, 
      String? updatedAt, 
      String? thumbnailUrl, 
      String? iconUrl,}){
    _id = id;
    _userId = userId;
    _name = name;
    _type = type;
    _description = description;
    _status = status;
    _theme = theme;
    _icon = icon;
    _thumbnail = thumbnail;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _thumbnailUrl = thumbnailUrl;
    _iconUrl = iconUrl;
}

  Module.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _name = json['name'];
    _type = json['type'];
    _description = json['description'];
    _status = json['status'];
    _theme = json['theme'];
    _icon = json['icon'];
    _thumbnail = json['thumbnail'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _thumbnailUrl = json['thumbnail_url'];
    _iconUrl = json['icon_url'];
  }
  num? _id;
  num? _userId;
  String? _name;
  String? _type;
  String? _description;
  String? _status;
  String? _theme;
  String? _icon;
  String? _thumbnail;
  String? _createdAt;
  String? _updatedAt;
  String? _thumbnailUrl;
  String? _iconUrl;
Module copyWith({  num? id,
  num? userId,
  String? name,
  String? type,
  String? description,
  String? status,
  String? theme,
  String? icon,
  String? thumbnail,
  String? createdAt,
  String? updatedAt,
  String? thumbnailUrl,
  String? iconUrl,
}) => Module(  id: id ?? _id,
  userId: userId ?? _userId,
  name: name ?? _name,
  type: type ?? _type,
  description: description ?? _description,
  status: status ?? _status,
  theme: theme ?? _theme,
  icon: icon ?? _icon,
  thumbnail: thumbnail ?? _thumbnail,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  thumbnailUrl: thumbnailUrl ?? _thumbnailUrl,
  iconUrl: iconUrl ?? _iconUrl,
);
  num? get id => _id;
  num? get userId => _userId;
  String? get name => _name;
  String? get type => _type;
  String? get description => _description;
  String? get status => _status;
  String? get theme => _theme;
  String? get icon => _icon;
  String? get thumbnail => _thumbnail;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get thumbnailUrl => _thumbnailUrl;
  String? get iconUrl => _iconUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['type'] = _type;
    map['description'] = _description;
    map['status'] = _status;
    map['theme'] = _theme;
    map['icon'] = _icon;
    map['thumbnail'] = _thumbnail;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['thumbnail_url'] = _thumbnailUrl;
    map['icon_url'] = _iconUrl;
    return map;
  }

}

/// id : 1
/// category_id : 1
/// name : "Sub Category 1"
/// status : "1"
/// priority : "normal"
/// created_at : "2023-03-02T05:06:12.000000Z"
/// updated_at : "2023-03-02T05:06:12.000000Z"

SubCategory subCategoryFromJson(String str) => SubCategory.fromJson(json.decode(str));
String subCategoryToJson(SubCategory data) => json.encode(data.toJson());
class SubCategory {
  SubCategory({
      num? id, 
      num? categoryId, 
      String? name, 
      String? status, 
      String? priority, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _categoryId = categoryId;
    _name = name;
    _status = status;
    _priority = priority;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  SubCategory.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _name = json['name'];
    _status = json['status'];
    _priority = json['priority'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _categoryId;
  String? _name;
  String? _status;
  String? _priority;
  String? _createdAt;
  String? _updatedAt;
SubCategory copyWith({  num? id,
  num? categoryId,
  String? name,
  String? status,
  String? priority,
  String? createdAt,
  String? updatedAt,
}) => SubCategory(  id: id ?? _id,
  categoryId: categoryId ?? _categoryId,
  name: name ?? _name,
  status: status ?? _status,
  priority: priority ?? _priority,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get categoryId => _categoryId;
  String? get name => _name;
  String? get status => _status;
  String? get priority => _priority;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['name'] = _name;
    map['status'] = _status;
    map['priority'] = _priority;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// id : 1
/// user_id : 1
/// module_id : 1
/// cate_by : "admin"
/// name : "Atta, Rice"
/// status : "1"
/// priority : "high"
/// image : "1681204606-6435257ecd62f.png"
/// created_at : "2023-03-02T05:05:38.000000Z"
/// updated_at : "2023-04-11T09:17:15.000000Z"
/// image_url : "$baseurl/public/storage/image/1681204606-6435257ecd62f.png"

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());
class Category {
  Category({
      num? id, 
      num? userId, 
      num? moduleId, 
      String? cateBy, 
      String? name, 
      String? status, 
      String? priority, 
      String? image, 
      String? createdAt, 
      String? updatedAt, 
      String? imageUrl,}){
    _id = id;
    _userId = userId;
    _moduleId = moduleId;
    _cateBy = cateBy;
    _name = name;
    _status = status;
    _priority = priority;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imageUrl = imageUrl;
}

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _moduleId = json['module_id'];
    _cateBy = json['cate_by'];
    _name = json['name'];
    _status = json['status'];
    _priority = json['priority'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imageUrl = json['image_url'];
  }
  num? _id;
  num? _userId;
  num? _moduleId;
  String? _cateBy;
  String? _name;
  String? _status;
  String? _priority;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  String? _imageUrl;
Category copyWith({  num? id,
  num? userId,
  num? moduleId,
  String? cateBy,
  String? name,
  String? status,
  String? priority,
  String? image,
  String? createdAt,
  String? updatedAt,
  String? imageUrl,
}) => Category(  id: id ?? _id,
  userId: userId ?? _userId,
  moduleId: moduleId ?? _moduleId,
  cateBy: cateBy ?? _cateBy,
  name: name ?? _name,
  status: status ?? _status,
  priority: priority ?? _priority,
  image: image ?? _image,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  imageUrl: imageUrl ?? _imageUrl,
);
  num? get id => _id;
  num? get userId => _userId;
  num? get moduleId => _moduleId;
  String? get cateBy => _cateBy;
  String? get name => _name;
  String? get status => _status;
  String? get priority => _priority;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['module_id'] = _moduleId;
    map['cate_by'] = _cateBy;
    map['name'] = _name;
    map['status'] = _status;
    map['priority'] = _priority;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['image_url'] = _imageUrl;
    return map;
  }

}

/// id : 1
/// user_id : 43
/// zone_id : 1
/// module_id : 1
/// name : "Store 1"
/// phone : "4545454545"
/// email : "store1@gmail.com"
/// address : "rajkot"
/// tax : "10"
/// minTime : "10"
/// maxTime : "10"
/// timeType : "hours"
/// logo : "1677753316-64007be4b0fb4.png"
/// cover : "1680960615-64316c67b0278.png"
/// latitude : "25.749654223123247"
/// longitude : "82.65700995588377"
/// status : "1"
/// created_at : "2023-03-02T05:04:24.000000Z"
/// updated_at : "2023-04-08T08:00:15.000000Z"
/// logo_url : "$baseurl/public/storage/image/1677753316-64007be4b0fb4.png"
/// cover_url : "$baseurl/public/storage/image/1680960615-64316c67b0278.png"

Store storeFromJson(String str) => Store.fromJson(json.decode(str));
String storeToJson(Store data) => json.encode(data.toJson());
class Store {
  Store({
      num? id, 
      num? userId, 
      num? zoneId, 
      num? moduleId, 
      String? name, 
      String? phone, 
      String? email, 
      String? address, 
      String? tax, 
      String? minTime, 
      String? maxTime, 
      String? timeType, 
      String? logo, 
      String? cover, 
      String? latitude, 
      String? longitude, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? logoUrl, 
      String? coverUrl,}){
    _id = id;
    _userId = userId;
    _zoneId = zoneId;
    _moduleId = moduleId;
    _name = name;
    _phone = phone;
    _email = email;
    _address = address;
    _tax = tax;
    _minTime = minTime;
    _maxTime = maxTime;
    _timeType = timeType;
    _logo = logo;
    _cover = cover;
    _latitude = latitude;
    _longitude = longitude;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _logoUrl = logoUrl;
    _coverUrl = coverUrl;
}

  Store.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _zoneId = json['zone_id'];
    _moduleId = json['module_id'];
    _name = json['name'];
    _phone = json['phone'];
    _email = json['email'];
    _address = json['address'];
    _tax = json['tax'];
    _minTime = json['minTime'];
    _maxTime = json['maxTime'];
    _timeType = json['timeType'];
    _logo = json['logo'];
    _cover = json['cover'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _logoUrl = json['logo_url'];
    _coverUrl = json['cover_url'];
  }
  num? _id;
  num? _userId;
  num? _zoneId;
  num? _moduleId;
  String? _name;
  String? _phone;
  String? _email;
  String? _address;
  String? _tax;
  String? _minTime;
  String? _maxTime;
  String? _timeType;
  String? _logo;
  String? _cover;
  String? _latitude;
  String? _longitude;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _logoUrl;
  String? _coverUrl;
Store copyWith({  num? id,
  num? userId,
  num? zoneId,
  num? moduleId,
  String? name,
  String? phone,
  String? email,
  String? address,
  String? tax,
  String? minTime,
  String? maxTime,
  String? timeType,
  String? logo,
  String? cover,
  String? latitude,
  String? longitude,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? logoUrl,
  String? coverUrl,
}) => Store(  id: id ?? _id,
  userId: userId ?? _userId,
  zoneId: zoneId ?? _zoneId,
  moduleId: moduleId ?? _moduleId,
  name: name ?? _name,
  phone: phone ?? _phone,
  email: email ?? _email,
  address: address ?? _address,
  tax: tax ?? _tax,
  minTime: minTime ?? _minTime,
  maxTime: maxTime ?? _maxTime,
  timeType: timeType ?? _timeType,
  logo: logo ?? _logo,
  cover: cover ?? _cover,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  logoUrl: logoUrl ?? _logoUrl,
  coverUrl: coverUrl ?? _coverUrl,
);
  num? get id => _id;
  num? get userId => _userId;
  num? get zoneId => _zoneId;
  num? get moduleId => _moduleId;
  String? get name => _name;
  String? get phone => _phone;
  String? get email => _email;
  String? get address => _address;
  String? get tax => _tax;
  String? get minTime => _minTime;
  String? get maxTime => _maxTime;
  String? get timeType => _timeType;
  String? get logo => _logo;
  String? get cover => _cover;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get logoUrl => _logoUrl;
  String? get coverUrl => _coverUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['zone_id'] = _zoneId;
    map['module_id'] = _moduleId;
    map['name'] = _name;
    map['phone'] = _phone;
    map['email'] = _email;
    map['address'] = _address;
    map['tax'] = _tax;
    map['minTime'] = _minTime;
    map['maxTime'] = _maxTime;
    map['timeType'] = _timeType;
    map['logo'] = _logo;
    map['cover'] = _cover;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['logo_url'] = _logoUrl;
    map['cover_url'] = _coverUrl;
    return map;
  }

}