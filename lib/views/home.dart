import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newproject/controllers/api_service.dart';
import 'package:newproject/modals/ProductsModal.dart';
import 'package:http/http.dart' as http;
import 'package:newproject/views/detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String baseUrl = "https://dummyjson.com/products";

  final ApiService apiService = ApiService();
  final ScrollController _scrollController = ScrollController();
  List<Product> products = [];
  int skip = 0;
  int limit = 10;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
    print('------products-----${products}');
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !isLoading) {
      fetchProducts();
    }
  }

  Future<void> fetchProducts() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    final fetchPoducts = await apiService.fetchProducts(skip, limit);
    print('------fetchPoducts-----${fetchPoducts}');

    setState(() {
      products.addAll(fetchPoducts);
      print('------fetchPoducts-----${fetchPoducts}');
      print('------products-----${products}');

      skip++;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: products.length + 1,
        itemBuilder: (context, index) {
          if (index == products.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child:
                    isLoading ? CircularProgressIndicator() : SizedBox.shrink(),
              ),
            );
          }
          final pro = products[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detail(product: pro),
                ),
              );
            },
            child: Card(
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Image.network(
                    pro.images[0],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  pro.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  pro.description,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
