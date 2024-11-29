String sanitizeXmlString(String xml) {
  final RegExp pattern = RegExp(r'<\d+>');

  String sanitizedXml = xml.replaceAll(pattern, '');

  // sanitizedXml = sanitizedXml.replaceAll('<', '&lt;').replaceAll('>', '&gt;');

  return sanitizedXml;
}
