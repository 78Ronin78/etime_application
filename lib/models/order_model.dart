class Order {
  String orderId;

  String name;
  String orderStatus;

  String datetime;
  String orderOption;
  String amount;
  Order(
      {required this.amount,
      required this.name,
      required this.datetime,
      required this.orderId,
      required this.orderOption,
      required this.orderStatus});
}
