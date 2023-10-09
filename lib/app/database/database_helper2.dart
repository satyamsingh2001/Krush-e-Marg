import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Product {
  final int? id;
  final String? name;
  final double? price;
  final double? mrp;
  final int? quantity;
  final String? storeName;
  final String? imageUrl;
  final String? attribute;
  final String? unit;
  final int? size;
  final String? productId;
  final String? storeId;

  Product(
      {this.id,
      this.name,
      this.price,
      this.mrp,
      this.quantity,
      this.storeName,
      this.imageUrl,
      this.attribute,
      this.unit,
      this.size,
      this.productId,
      this.storeId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'mrp': mrp,
      'quantity': quantity,
      'storeName': storeName,
      'imageUrl': imageUrl,
      'attribute': attribute,
      'unit': unit,
      'size': size,
      'productId': productId,
      'storeId': storeId
    };
  }

  Map<String, dynamic> toMapForApi() {
    return {
      "product_name": "$name",
      "product_id": "$productId",
      "price": "$price",
      "quantity": "$quantity",
      "attribute": "$attribute",
      "unit": "$unit",
      "size": "$size",
      "store_id": "$storeId",
      "product_amount": '${quantity! * price!}'
      // Add other desired parameters here...
    };
  }
}

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init();
  static Database? _database;
  // Map<String, List<Product>> productsByStore = {}; // Universal list by store


  ProductDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('products.db');
    // await _loadProductsByStore(); // Load products into productsByStore
    return _database!;
  }


  // Future<void> _loadProductsByStore() async {
  //   final products = await fetchProducts();
  //   for (final product in products) {
  //     final storeId = product.storeId ?? "";
  //     if (!productsByStore.containsKey(storeId)) {
  //       productsByStore[storeId] = [];
  //     }
  //     productsByStore[storeId]?.add(product);
  //   }
  // }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE products (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      price REAL,
      mrp REAL,
      quantity INTEGER,
      storeName TEXT,
      imageUrl TEXT,
      attribute TEXT,
      unit TEXT,
      size INTEGER,
      productId TEXT,
      storeId TEXT
    )
  ''');
  }

  Future<int> addProduct(Product product) async {
    final db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  //
  Future<int> updateProductSizeByProductId(
      String productId, int size, int newQuantity) async {
    final db = await instance.database;
    return await db.update(
      'products',
      {'quantity': newQuantity},
      where: 'productId = ? AND size = ?',
      whereArgs: [productId, size],
    );
  }

  Future<int> removeProduct(int id) async {
    final db = await instance.database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Product>> fetchProducts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        mrp: maps[i]['mrp'],
        quantity: maps[i]['quantity'],
        storeName: maps[i]['storeName'],
        imageUrl: maps[i]['imageUrl'],
        attribute: maps[i]['attribute'],
        unit: maps[i]['unit'],
        size: maps[i]['size'],
        productId: maps[i]['productId'],
        storeId: maps[i]['storeId'],
      );
    });
  }

  Future<void> clearProducts() async {
    final db = await instance.database;
    await db.delete('products');
  }
}

void addProductToDatabase(
    final String name,
    final double price,
    final double mrp,
    final String storeName,
    final String imageUrl,
    final int size,
    final String productid,
    final String storeid,
    final String Unit,
    final int Quantity,
    final String Attribute) async {
  final product = Product(
    name: name,
    price: price,
    mrp: mrp,
    storeName: storeName,
    imageUrl: imageUrl,
    size: size,
    productId: productid,
    storeId: storeid,
    unit: Unit,
    quantity: Quantity,
    attribute: Attribute,
  );
  final result = await ProductDatabase.instance.addProduct(product);
  print('Product added with ID: $result');
}

void updateProduct(String priductID, int productSize, int quant) async {
  final productId = priductID; // Name of the product you want to update
  final size = productSize;
  final newQuantity = quant; // The new size value
  await ProductDatabase.instance
      .updateProductSizeByProductId(productId, size, newQuantity);
}

void fetchProducts() async {
  final productList = await ProductDatabase.instance.fetchProducts();
  for (final product in productList) {
    // print('Product ID: ${product.id}, Name: ${product.name}, Price: ${product.price}');
    // print('name: ${product.name}, storeName: ${product.storeName}, Image URL: ${product.imageUrl}');
    // print('price: ${product.price}, mrp: ${product.mrp}');
    // print(productList.length.toString()+'------------------------------------------------');
  }
}

void removeProduct(int id) async {
  final productId = id; // Provide the ID of the product to remove
  final result = await ProductDatabase.instance.removeProduct(productId);
  print('Product removed: $result');
}

void deleteProduct() async {
  await ProductDatabase.instance.clearProducts();
}

// class DataBase extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   final product = Product(
//                     name: 'Example Product',
//                     price: 10.99,
//                     mrp: 10,
//                     imageUrl: 'https://example.com/product-image.jpg',
//                   );
//                   final result =
//                       await ProductDatabase.instance.addProduct(product);
//                   print('Product added with ID: $result');
//                 },
//                 child: Text('Add Product'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   final productId =
//                       1; // Provide the ID of the product to remove
//                   final result =
//                       await ProductDatabase.instance.removeProduct(productId);
//                   print('Product removed: $result');
//                 },
//                 child: Text('Remove Product'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   final productList =
//                       await ProductDatabase.instance.fetchProducts();
//                   for (final product in productList) {
//                     print(
//                         'Product ID: ${product.id}, Name: ${product.name}, Price: ${product.price}');
//                     print(
//                         'name: ${product.name}, storeName: ${product.storeName}, Image URL: ${product.imageUrl}');
//                     print('price: ${product.price}, mrp: ${product.mrp}');
//                     print(productList.length.toString() +
//                         '------------------------------------------------');
//                   }
//                 },
//                 child: Text('Fetch Products'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
