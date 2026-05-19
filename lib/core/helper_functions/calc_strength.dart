double calcStrength(String password) {
  if (password.isEmpty) return 0;
  double strength = 0;
  if (password.length >= 8) strength += 0.25;
  if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
  if (password.contains(RegExp(r'[0-9]'))) strength += 0.25;
  if (password.contains(RegExp(r'[!@#\$&*~]'))) strength += 0.25;
  return strength;
}
