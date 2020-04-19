class PasswordValidation{
  String validatePassword(String _value) {
    return (_value.isEmpty) ? 'Password is required' : null;
  }

  String passwordLenghtAndEqual(int _length, String _password, String _confirmPassword) {
    String that;
    that = PasswordValidation().passwordLength(_length);
    if (that != null) return that;
    that = PasswordValidation().passwordEqual(_password, _confirmPassword);
    return that;
  }

  String passwordLength(int _length){
    return _length < 6 ? 'Field must have six or mor caracters' : null;
  }
  String passwordEqual(String _password, String _confirmPassword){
    return (_password != _confirmPassword) ? 'Password must be equal': null;
  }
}