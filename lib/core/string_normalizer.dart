const _diacritics = {
  'á': 'a', 'à': 'a', 'â': 'a', 'ã': 'a',
  'é': 'e', 'ê': 'e',
  'í': 'i',
  'ó': 'o', 'ô': 'o', 'õ': 'o',
  'ú': 'u',
  'ç': 'c',
};

String normalize(String value) => value
    .toLowerCase()
    .replaceAllMapped(RegExp(r'[áàâãéêíóôõúç]'), (m) => _diacritics[m[0]]!)
    .replaceAll(' ', '_');