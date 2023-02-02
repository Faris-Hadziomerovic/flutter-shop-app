class Validator {
  static const urlPattern =
      r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:,.;]*)?";

  static const imageUrlPattern =
      r"(https?|ftp)://([-A-Za-z0-9.]+)(/[-A-Za-z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Za-z0-9+&@#/%=~_|!:,.;]*)?.(png|jpg|jpeg)$";

  static String? validatePrice(String? value) {
    final price = double.tryParse(value as String);

    if (price == null) {
      return 'Please enter a valid number';
    } else if (price < 0) {
      return 'The price cannot be negative';
    }

    return null;
  }

  static String? validateTitle(String? title) {
    const minLength = 2;
    const maxLength = 30;

    if (title?.isEmpty ?? false) {
      return 'Please provide a title for the product';
    }
    if (title!.length <= minLength) {
      return 'The title should be longer than $minLength characters';
    }
    if (title.length >= maxLength) {
      return 'The title should be shorter than $maxLength characters';
    }

    return null;
  }

  static String? validateDescription(String? description) {
    const minLength = 10;
    const maxLength = 500;

    if (description?.isEmpty ?? false) {
      return 'Please provide a description for the product';
    } else if (description!.length <= minLength) {
      return 'The description should be longer than $minLength characters';
    } else if (description.length >= maxLength) {
      return 'The description should be shorter than $maxLength characters';
    }

    return null;
  }

  static String? validateImageUrl(String? imageUrl) {
    if (imageUrl?.isEmpty ?? false) return 'Please provide an image URL';

    final result = RegExp(imageUrlPattern, caseSensitive: false).firstMatch(imageUrl!);

    if (result == null) {
      return 'Please provide a valid image URL \n(it should end in png, jpg or jpeg)';
    }

    return null;
  }
}
