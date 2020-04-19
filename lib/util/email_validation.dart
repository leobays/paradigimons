class EmailValidation {

  String emailValidation(String value) {
    if (value.isEmpty) return 'E-mail is required';
    if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
    .hasMatch(value)) return 'Invalid e-mail typed';
    return null;
  }
}