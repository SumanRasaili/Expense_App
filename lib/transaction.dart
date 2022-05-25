class Transaction{
  late final String id;
  late final String title;
  late final double amount;
  late final DateTime dateTime; 
  Transaction({required this.amount,required this.id,required this.dateTime,required this.title});
}
