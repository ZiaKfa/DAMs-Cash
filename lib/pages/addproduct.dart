import 'package:dams_cash/models/auth.dart';
import 'package:dams_cash/models/branch.dart';
import 'package:dams_cash/models/product.dart';
import 'package:dams_cash/pages/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddproductState createState() => _AddproductState();
}

class _AddproductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _productionCostController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama produk tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _stockController,
                decoration: const InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Stok tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _productionCostController,
                decoration: const InputDecoration(labelText: 'HPP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'HPP tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              DropdownButtonFormField<String>(
                value: "default",
                decoration: const InputDecoration(labelText: 'Kategori'),
                items: const [
                  DropdownMenuItem(
                    value: 'default',
                    child: Text('Pilih Kategori'),
                  ),
                  DropdownMenuItem(
                    value: 'salad',
                    child: Text('Salad'),
                  ),
                  DropdownMenuItem(
                    value: 'buko',
                    child: Text('Buko'),
                  ),
                  DropdownMenuItem(
                    value: 'rujak',
                    child: Text('Rujak'),
                  ),
                  DropdownMenuItem(
                    value: 'drink',
                    child: Text('Es'),
                  ),
                  DropdownMenuItem(
                    value: 'jelly',
                    child: Text('Minuman Jelly'),
                  ),
                  DropdownMenuItem(
                    value: 'pudding',
                    child: Text('Pudding'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _categoryController.text = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kategori tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final branch = Provider.of<Branch>(context, listen: false);
                  final auth = Provider.of<Auth>(context, listen: false);
              
                  if (_formKey.currentState!.validate()) {
                    final product = Product(
                      id : branch.fullProducts.length + 1,
                      name: _nameController.text,
                      price: int.parse(_priceController.text),
                      stock: int.parse(_stockController.text),
                      category: _categoryController.text,
                      productionCost: int.parse(_productionCostController.text),
                      userId: auth.currentUser.id,
                    );
                    branch.addProduct(product);
                    branch.postProduct(product);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Produk Ditambahkan'),
                          content: const Text('Produk berhasil ditambahkan'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductPage()));
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    
                    );
                  }
                },
                child: const Text('Tambah'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
