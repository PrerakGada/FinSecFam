enum TransactionType { Income, Expense }

enum InvestmentType {
  Stock,
  Bond,
  SIP,
  MutualFund,
  FixedDeposit,
  RecurringDeposit,
  Cryptocurrency,
}

class User {
  String? id;
  String? email;
  String? name;

  User({this.id, this.email, this.name});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }
}

class Transaction {
  String? id;
  TransactionType? type;
  int? amount;
  String? description;
  DateTime? date;
  String? userId;
  User? user;

  Transaction({
    this.id,
    this.type,
    this.amount,
    this.description,
    this.date,
    this.userId,
    this.user,
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'type': type.toString().split('.').last, 'amount': amount, 'description': description, 'date': date?.toIso8601String(), 'userId': userId, 'user': user?.toJson()};
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      type: TransactionType.values.firstWhere((e) => e.toString() == 'TransactionType.${json['type']}'),
      amount: json['amount'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      userId: json['userId'],
      user: User.fromJson(json['user']),
    );
  }
}

class Investment {
  String? id;
  InvestmentType? type;
  double? amount;
  String? description;
  String? userId;
  User? user;

  Investment({this.id, this.type, this.amount, this.description, this.userId, this.user});

  Map<String, dynamic> toJson() {
    return {'id': id, 'type': type.toString().split('.').last, 'amount': amount, 'description': description, 'userId': userId, 'user': user?.toJson()};
  }

  factory Investment.fromJson(Map<String, dynamic> json) {
    return Investment(
        id: json['id'],
        type: InvestmentType.values.firstWhere((e) => e.toString() == 'InvestmentType.${json['type']}'),
        amount: json['amount'],
        description: json['description'],
        userId: json['userId'],
        user: User.fromJson(json['user']));
  }
}
