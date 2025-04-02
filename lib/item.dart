class Item {
  final String id; 
  String name; 
  int quantity; 
  double price; 
  String date;

  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.date
  });

  @override
  String toString() {
    return 'Item{id: $id, name: $name, quantity: $quantity, price: $price, date: $date}';
  }

  void updateQuantity(int newQuantity) {
    quantity = newQuantity;
  }

  void updatePrice(double newPrice) {
    price = newPrice;
  }

  void updateDate(String newDate) {
    date = newDate;
  }
}