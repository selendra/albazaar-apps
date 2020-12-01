class TrxHistoryModel {

  int amount;
  double fee;
  String id;
  String sender;
  String destination;
  String memo;
  String createdAt;
  TrxHistoryModel(Map<String, dynamic> data) {
    _fromJson(data);
  }

  void _fromJson(Map<String, dynamic> data){
    amount = data['amount'];
    fee = data['fee'];
    id =  data['id'];
    sender = data['sender'];
    destination =  data['destination'];
    memo = data['memo'];
    createdAt = data['created_at'];
  }
}