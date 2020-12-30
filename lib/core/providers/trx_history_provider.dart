import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/trx_history_m.dart';

class TrxHistoryProvider with ChangeNotifier {
  Backend _backend;

  GetRequest _getRequest;

  List<TrxHistoryModel> trxHistoryList = [];

  TrxHistoryProvider() {
    fetchTrxHistory();
  }

  Future<void> fetchTrxHistory() async {
    _backend = Backend();
    _getRequest = GetRequest();
    trxHistoryList = [];

    // Fetch History
    await _getRequest.getTrxHistory().then((value) {
      _backend.listData = json.decode(value.body);
      if (_backend.listData.isEmpty)
        trxHistoryList = null;
      else {
        for (var l in _backend.listData) {
          trxHistoryList.add(TrxHistoryModel(l));
        }
      }
    });

    notifyListeners();
  }
}
