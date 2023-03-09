import '../constants/validation_messages.dart';
import '../constants/validator_constants.dart';

class Validator {
  static String? validatePrice(String? value) {
    final price = double.tryParse(value as String);

    if (price == null) {
      return ValidationMessages.priceInvalid;
    } else if (price < 0) {
      return ValidationMessages.priceNegative;
    }

    return null;
  }

  static String? validateTitle(String? title) {
    if (title?.isEmpty ?? true) {
      return ValidationMessages.titleMissing;
    }

    if (title!.length < ValidatorConstants.titleMinLength) {
      return ValidationMessages.titleMinLength;
    }

    if (title.length > ValidatorConstants.titleMaxLength) {
      return ValidationMessages.titleMaxLength;
    }

    return null;
  }

  static String? validateDescription(String? description) {
    if (description?.isEmpty ?? true) {
      return ValidationMessages.descriptionMissing;
    }

    if (description!.length < ValidatorConstants.descriptionMinLength) {
      return ValidationMessages.descriptionMinLength;
    }

    if (description.length > ValidatorConstants.descriptionMaxLength) {
      return ValidationMessages.descriptionMaxLength;
    }

    return null;
  }

  static String? validateImageUrl(String? imageUrl) {
    if (imageUrl?.isEmpty ?? true) return ValidationMessages.imageUrlMissing;

    final result = RegExp(
      ValidatorConstants.imageUrlPattern,
      caseSensitive: false,
    ).firstMatch(imageUrl!);

    if (result == null) {
      return ValidationMessages.imageUrlInvalid;
    }

    return null;
  }

  static String? validateEmail(String? email) {
    if (email?.isEmpty ?? true) return ValidationMessages.emailMissing;

    final result = RegExp(
      ValidatorConstants.emailPattern,
      caseSensitive: false,
    ).firstMatch(email!);

    if (result == null) {
      return ValidationMessages.emailInvalid;
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password?.isEmpty ?? true) {
      return ValidationMessages.passwordMissing;
    }

    if (password!.length < ValidatorConstants.passwordMinLength) {
      return ValidationMessages.passwordLength;
    }

    final hasSpecialCharacter =
        RegExp(ValidatorConstants.specialCharactersPattern).firstMatch(password) != null;

    if (!hasSpecialCharacter) {
      return ValidationMessages.passwordOneSpecialCharacter;
    }

    final hasDigit = RegExp(ValidatorConstants.digitsPattern).firstMatch(password) != null;

    if (!hasDigit) {
      return ValidationMessages.passwordOneDigit;
    }

    final hasLetter = RegExp(ValidatorConstants.letterPattern).firstMatch(password) != null;

    if (!hasLetter) {
      return ValidationMessages.passwordOneLetter;
    }

    return null;
  }
}
