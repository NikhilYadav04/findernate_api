class PaymentGateway {
  final String svgUrl;
  final String label;

  const PaymentGateway({
    required this.svgUrl,
    required this.label,
  });
}

final List<PaymentGateway> paymentGateways = [
  PaymentGateway(
    svgUrl: 'assets/svg/Visa.svg',
    label: 'Visa',
  ),
  PaymentGateway(
    svgUrl: 'assets/svg/Mastercard.svg',
    label: 'MasterCard',
  ),
  PaymentGateway(
    svgUrl: 'assets/svg/Amex.svg',
    label: 'American Express',
  ),
  PaymentGateway(
    svgUrl: 'assets/svg/Paypal.svg',
    label: 'PayPal',
  ),
  PaymentGateway(
    svgUrl: 'assets/svg/Paypal.svg',
    label: 'Google Pay',
  ),
];
