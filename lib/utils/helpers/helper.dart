String normalizePhoneNumber(String value) {
  if (value.startsWith('09') || value.startsWith('07')) {
    return '+251${value.substring(1)}';
  } else if (value.startsWith('251')) {
    return '+$value';
  } else if (value.startsWith('9') || value.startsWith('7')) {
    return '+251$value';
  } else if (value.startsWith('+251')) {
    return value;
  } else {
    return value; // This shouldn't happen as regex should catch all cases
  }
}
