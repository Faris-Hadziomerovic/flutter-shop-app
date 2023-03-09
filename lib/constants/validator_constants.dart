/// The central place for constants used in various validations.
class ValidatorConstants {
  static const passwordMinLength = 8;
  static const descriptionMinLength = 10;
  static const descriptionMaxLength = 499;
  static const titleMinLength = 3;
  static const titleMaxLength = 34;

  static const specialCharactersPattern = r'[-_@$!%*#?&]+';
  static const digitsPattern = r'\d+';
  static const letterPattern = r'[a-zA-Z]+';
  static const passwordPattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$';
  static const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const imageUrlPattern = r'^https?://\S+\.(?:png|jpe?g|gif|webp)$';
}
