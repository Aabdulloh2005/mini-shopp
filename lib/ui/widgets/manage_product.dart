import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_simple_online_shop_cubit/data/models/product.dart';
import 'package:very_simple_online_shop_cubit/logic/blocs/product/product_bloc.dart';

class ManageProduct extends StatefulWidget {
  final bool isEdit;
  final Product? product;

  const ManageProduct({super.key, required this.isEdit, this.product});

  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.product != null) {
      _productNameController.text = widget.product!.title;
      _imageUrlController.text = widget.product!.imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProductBloc productBloc = context.read<ProductBloc>();
    return AlertDialog(
      title: Text(widget.isEdit ? 'Edit Product' : 'Add Product'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _productNameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a product name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageUrlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an image URL';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.isEdit && widget.product != null) {
                productBloc.add(
                  EditProductEvent(
                    id: widget.product!.id,
                    title: _productNameController.text,
                    imageUrl: _imageUrlController.text,
                  ),
                );
              } else {
                productBloc.add(
                  AddProductEvent(
                    title: _productNameController.text,
                    imageUrl: _imageUrlController.text,
                  ),
                );
              }
              Navigator.of(context).pop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
