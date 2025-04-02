class Item {
  final String id; 
  final String name; 
  int quantity; 
  double price; 

  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  String toString() {
    return 'Item{id: $id, name: $name, quantity: $quantity, price: $price}';
  }

  void updateQuantity(int newQuantity) {
    quantity = newQuantity;
  }

  void updatePrice(double newPrice) {
    price = newPrice;
  }
}