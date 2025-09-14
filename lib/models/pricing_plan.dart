class PricingPlan {
  final String name;
  final String description;
  final double price;
  final String currency;
  final List<String> features;
  final bool isPopular;
  final String ctaText;

  const PricingPlan({
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.features,
    this.isPopular = false,
    required this.ctaText,
  });
}
