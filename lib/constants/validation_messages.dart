import './validator_constants.dart';

/// Messages used in form validation when something goes wrong. <br>
/// Used together with <code>ValidatorConstants</code> class.
class ValidationMessages {
  static const priceNegative = 'The price cannot be negative';

  static const priceInvalid = 'Please enter a valid number';

  static const titleMissing = 'Please provide a title for the product';

  static const titleMinLength =
      'The title should be longer than ${ValidatorConstants.titleMinLength - 1} characters';

  static const titleMaxLength =
      'The title should be shorter than ${ValidatorConstants.titleMaxLength + 1} characters';

  static const descriptionMissing = 'Please provide a description for the product';

  static const descriptionMinLength =
      'The description should be longer than ${ValidatorConstants.descriptionMinLength - 1} characters';

  static const descriptionMaxLength =
      'The description should be shorter than ${ValidatorConstants.descriptionMaxLength + 1} characters';

  static const imageUrlMissing = 'Please provide an image URL';

  static const imageUrlInvalid =
      'Please provide a valid image URL \n(it should end in png, jpg, jpeg, git or webp)';

  static const emailMissing = 'Please provide an email';

  static const emailInvalid = 'Please provide a valid email.';

  static const passwordConfirmationMissing = 'Please re-enter the password';

  static const passwordMissing = 'Please provide a password';

  static const passwordsDoNotMatch = 'Passwords do not match!';

  static const passwordOneLetter = 'The password must contain at least one letter.';

  static const passwordOneDigit = 'The password must contain at least one digit.';

  static const passwordOneSpecialCharacter =
      'The password must contain at least special character.';

  static const passwordLength =
      'The password must be at least ${ValidatorConstants.passwordMinLength} characters long.';
}
