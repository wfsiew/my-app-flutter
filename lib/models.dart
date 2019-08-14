class Product {
  int productID;
  String name;
  String description;
  double price;

  Product({
    this.productID,
    this.name,
    this.description,
    this.price
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productID: json['productID'],
      name: json['name'],
      description: json['description'],
      price: json['price']
    );
  }

  Map<String, dynamic> toJson() => {
    'productID': productID,
    'name': name,
    'description': description,
    'price': price
  };
}

class ProductArgs {
  final int productID;
  final String name;

  ProductArgs(this.productID, this.name);
}

class CartLine {
  int cartLineID;
  Product product;
  int quantity;

  CartLine({
    this.cartLineID,
    this.product,
    this.quantity
  });

  factory CartLine.fromJson(Map<String, dynamic> json) {
    return CartLine(
      cartLineID: json['cartLineID'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity']
    );
  }

  Map<String, dynamic> toJson() => {
    'cartLineID': cartLineID,
    'product': product.toJson(),
    'quantity': quantity
  };
}

class CartSummary {
  int totalQuantity;
  double totalPrice;

  CartSummary({
    this.totalQuantity, 
    this.totalPrice
  });

  factory CartSummary.getSummary(List<CartLine> lines) {
    int qty = 0;
    double total = 0;

    lines.forEach((x) {
      qty += x.quantity;
      total += x.product.price * x.quantity;
    });

    return CartSummary(
      totalQuantity: qty,
      totalPrice: total
    );
  }
}