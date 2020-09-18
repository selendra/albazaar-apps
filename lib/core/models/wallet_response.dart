class WalletResponse {
  Message message;

  WalletResponse({this.message});

  WalletResponse.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message.toJson();
    }
    return data;
  }
}

class Message {
  String wallet;
  String seed;

  Message({this.wallet, this.seed});

  Message.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'];
    seed = json['seed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet'] = this.wallet;
    data['seed'] = this.seed;
    return data;
  }
}