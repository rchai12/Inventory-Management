import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'item.dart';

class InventoryHomePage extends StatefulWidget {
  InventoryHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _InventoryHomePageState createState() => _InventoryHomePageState();
}

class _InventoryHomePageState extends State<InventoryHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  late Stream<List<Item>> _inventoryStream;

  @override
  void initState() {
    super.initState();
    _inventoryStream = _getInventoryItems();
  }

  Stream<List<Item>> _getInventoryItems() {
    return _firestore
        .collection('inventory')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Item(
          id: doc.id,
          name: doc['name'],
          quantity: doc['quantity'],
          price: doc['price'],
          date: doc['date'],
        );
      }).toList();
    });
  }

  Future<void> _editItem(String id, String currentName, int currentQuantity, double currentPrice) async {
    _nameController.text = currentName;
    _quantityController.text = currentQuantity.toString();
    _priceController.text = currentPrice.toString();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Item Name'),
              ),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final String name = _nameController.text;
                final int quantity = int.parse(_quantityController.text);
                final double price = double.parse(_priceController.text);
                if (name.isNotEmpty && quantity > 0 && price > 0) {
                  await _firestore.collection('inventory').doc(id).update({
                    'name': name,
                    'quantity': quantity,
                    'price': price,
                    'date': DateTime.now().toString(),
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Update Item'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addItem() async {
    final String name = _nameController.text;
    final int quantity = int.parse(_quantityController.text);
    final double price = double.parse(_priceController.text);

    if (name.isNotEmpty && quantity > 0 && price > 0) {
      await _firestore.collection('inventory').add({
        'name': name,
        'quantity': quantity,
        'price': price,
        'date': DateTime.now().toString(),
      });
      _nameController.clear();
      _quantityController.clear();
      _priceController.clear();
    }
  }

  Future<void> _deleteItem(String id) async {
    await _firestore.collection('inventory').doc(id).delete();
  }

  Future<void> _showDeleteConfirmationDialog(String id) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Item"),
          content: Text("Are you sure you want to delete this item? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteItem(id);
                Navigator.pop(context);
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<Item>>(
        stream: _inventoryStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items available.'));
          }
          final inventoryItems = snapshot.data!;
          return ListView.builder(
            itemCount: inventoryItems.length,
            itemBuilder: (context, index) {
              final item = inventoryItems[index];
              return Dismissible(
                key: Key(item.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  _showDeleteConfirmationDialog(item.id);
                  return false;
                },
                child: ListTile(
                  title: Text(item.name),
                  subtitle: Text(
                    'Quantity: ${item.quantity} | Price: \$${item.price} | Update Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(item.date))}',
                  ),
                  onTap: () {
                    _editItem(item.id, item.name, item.quantity, item.price);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add New Item'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Item Name'),
                    ),
                    TextField(
                      controller: _quantityController,
                      decoration: InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: _priceController,
                      decoration: InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      _addItem();
                      Navigator.pop(context);
                    },
                    child: Text('Add Item'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }
}

