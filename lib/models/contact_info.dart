class ContactInfo {
  final String name;
  final String email;
  final String phone;
  final String location;
  final String github;
  final String linkedin;
  final String? website;

  const ContactInfo({
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.github,
    required this.linkedin,
    this.website,
  });
}
