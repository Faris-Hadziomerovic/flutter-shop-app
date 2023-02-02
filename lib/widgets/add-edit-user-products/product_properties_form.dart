import 'package:flutter/material.dart';

import '../../helpers/input_helper.dart';
import '../../helpers/validator.dart';
import '../../models/mutable_product.dart';
import '../../providers/product.dart';

class ProductPropertiesForm extends StatefulWidget {
  final Product? product;

  const ProductPropertiesForm({super.key, this.product});

  @override
  State<ProductPropertiesForm> createState() => _ProductPropertiesFormState();
}

class _ProductPropertiesFormState extends State<ProductPropertiesForm> {
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  late final MutableProduct _product;

  @override
  void initState() {
    super.initState();
    _product = widget.product == null
        ? MutableProduct(id: DateTime.now().millisecondsSinceEpoch.toString())
        : MutableProduct.fromProduct(product: widget.product as Product);
    _imageController.text = widget.product?.imageUrl ?? '';
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
    _updateImageUrl();

    final formIsValid = _form.currentState?.validate() ?? false;

    if (formIsValid) {
      _form.currentState?.save();
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
                      onFieldSubmitted: (_) => _saveForm(),
                      validator: Validator.validateImageUrl,
                    ),
                  ),
                ],
              ),
              Container(
                width: 150,
                height: 60,
                margin: const EdgeInsets.all(25),
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
