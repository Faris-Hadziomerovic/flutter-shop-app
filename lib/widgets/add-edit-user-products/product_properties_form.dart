import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../helpers/input_helper.dart';
import '../../helpers/validator.dart';
import '../../models/mutable_product.dart';
import '../../providers/product.dart';
import '../../providers/products_provider.dart';

class ProductPropertiesForm extends StatefulWidget {
  final Product? product;

  const ProductPropertiesForm({super.key, this.product});

  @override
  State<ProductPropertiesForm> createState() => _ProductPropertiesFormState();
}

class _ProductPropertiesFormState extends State<ProductPropertiesForm> {
  late final MutableProduct _product;
  final _form = GlobalKey<FormState>();
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();

  bool get _isEditMode => widget.product != null;

  @override
  void initState() {
    super.initState();

    _product = _isEditMode
        ? MutableProduct.fromProduct(product: widget.product as Product)
        : MutableProduct(id: DateTime.now().millisecondsSinceEpoch.toString());

    _imageController.text = _product.imageUrl ?? '';
    _imageFocusNode.addListener(_updateImageUrl);
  }

  @override
  void dispose() {
    super.dispose();
    _imageFocusNode.removeListener(_updateImageUrl);
    _imageFocusNode.dispose();
    _imageController.dispose();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus && Validator.validateImageUrl(_imageController.text) == null) {
      // force the widget to rebuild so the image can use the new url from the controller
      setState(() {});
    }
  }

  void _saveForm() {
    final formIsValid = _form.currentState?.validate() ?? false;

    if (formIsValid) {
      _form.currentState?.save();

      if (_isEditMode) {
        Provider.of<Products>(context, listen: false).update(
          id: _product.id,
          updatedProduct: _product.toProduct(),
        );

        Fluttertoast.showToast(
          msg: '${_product.title} has been updated.',
          backgroundColor: Colors.black54,
        );
      } else {
        Provider.of<Products>(context, listen: false).add(
          _product.toProduct(),
          insertAsFirst: true,
        );

        Fluttertoast.showToast(
          msg: '${_product.title} has been added to your products.',
          backgroundColor: Colors.black54,
        );
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const double distanceBetweenFields = 15.0;

    return Form(
      key: _form,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.product?.title,
                textInputAction: TextInputAction.next,
                decoration: InputHelper.createInputDecoration(
                  context,
                  labelText: 'Title',
                ),
                onSaved: (newTitle) => _product.title = newTitle,
                validator: Validator.validateTitle,
              ),
              const SizedBox(height: distanceBetweenFields),
              TextFormField(
                initialValue: widget.product?.price.toStringAsFixed(2),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputHelper.createInputDecoration(
                  context,
                  labelText: 'Price',
                  prefixText: '\$ ',
                ),
                onSaved: (newPrice) => _product.price = double.tryParse(newPrice as String),
                validator: Validator.validatePrice,
              ),
              const SizedBox(height: distanceBetweenFields),
              TextFormField(
                initialValue: widget.product?.description,
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: 5,
                decoration: InputHelper.createInputDecoration(
                  context,
                  labelText: 'Description',
                ),
                onSaved: (newDescription) => _product.description = newDescription,
                validator: Validator.validateDescription,
              ),
              const SizedBox(height: distanceBetweenFields),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_imageController.text.isNotEmpty)
                    Container(
                      height: 60,
                      width: 60,
                      margin: const EdgeInsets.only(right: distanceBetweenFields),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: Image.network(
                        _imageController.text,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  Expanded(
                    child: TextFormField(
                      controller: _imageController,
                      focusNode: _imageFocusNode,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      decoration: InputHelper.createInputDecoration(
                        context,
                        labelText: 'Image URL',
                      ),
                      onSaved: (newImageUrl) => _product.imageUrl = newImageUrl,
                      onFieldSubmitted: (_) => _updateImageUrl(),
                      validator: Validator.validateImageUrl,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: distanceBetweenFields),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: _saveForm,
                  icon: const Icon(Icons.check),
                  label: Text(
                    'Save',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
