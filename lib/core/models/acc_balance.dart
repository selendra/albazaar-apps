class Balance {
  Balance({
    this.balance,
    this.buyingLiabilities,
    this.sellingLiabilities,
    this.assetType,
  });

  dynamic balance;
  dynamic buyingLiabilities;
  dynamic sellingLiabilities;
  dynamic assetType;

  Balance.fromJson(Map<dynamic, dynamic> json) {
    balance = json["balance"];
    buyingLiabilities = json["buying_liabilities"];
    sellingLiabilities = json["selling_liabilities"];
    assetType = json["asset_type"];
  }
}

List<Balance> mBalance = [];
