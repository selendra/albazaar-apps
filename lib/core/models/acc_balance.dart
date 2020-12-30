class Balance {
  Balance({
    this.token,
    this.symbol,
  });

  String token;
  String symbol;

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        token: json["token"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "symbol": symbol,
      };
}

Balance mBalance = Balance();
