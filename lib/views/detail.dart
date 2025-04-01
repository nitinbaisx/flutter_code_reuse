import 'package:flutter/material.dart';
import 'package:newproject/modals/ProductsModal.dart'; // Ensure you import the Product model

class Detail extends StatefulWidget {
  final Product product; // ✅ Add product parameter

  const Detail({Key? key, required this.product}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.product.title)), // ✅ Display product title
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.product.images.isNotEmpty
                ? widget.product.images[0]
                : ''),
            SizedBox(height: 10),
            Text(
              widget.product.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(widget.product.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Price: \$${widget.product.price}",
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
