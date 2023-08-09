import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webapp/data/Repository/product_repository.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<productProvider>(context, listen: false).getAllProduct();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Product Detail"),
        ),
        body: Consumer<productProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const CircularProgressIndicator();
            }
            final product = value.productDetail;
            return ListView.builder(
              itemCount: product.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(product[index].title ?? ''),
                );
              },
            );
          },
        ));
  }
}
