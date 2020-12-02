import 'package:selendra_marketplace_app/all_export.dart';

class TransactionHistory extends StatelessWidget {
  
  final String title;
  final String amount;
  final String logo;

  TransactionHistory({this.title, this.amount, this.logo});

  List _buildList(List<TrxHistoryModel> history, BuildContext context) {

    print("length ${history.length}");
    
    List<Widget> listItems = List();

    for (int i = 0; i < history.length; i++) {
      listItems.add(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultRadius),
              side: BorderSide(
                color: kDefaultColor,
              ),
            ),
            child: ListTile(
              onTap: () async {
                await Components.dialog(
                  context, 
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ItemList(title: "Id", trailing: history[i].id),
                      ItemList(title: "Created At", trailing: AppUtils.timeStampToDateTime(history[i].createdAt)),
                      ItemList(title: "Sender", trailing: history[i].sender),
                      ItemList(title: "Destination", trailing: history[i].destination),
                      ItemList(title: "Amount", trailing: history[i].amount.toString()),
                      ItemList(title: "Fee", trailing: history[i].fee.toString()),
                      ItemList(title: "Memo", trailing: history[i].memo),
                    ],
                  ), 
                  Text("Transaction history", textAlign: TextAlign.left ,)
                );
              },
              trailing: Text(
                '${history[i].amount}',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              leading: Image.asset(logo, width: 30, height: 30),
              title: Text(
                'Sent',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ),
      );
    }
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    List<TrxHistoryModel> history = Provider.of<TrxHistoryProvider>(context).trxHistoryList;
    print(history.length);
    return Scaffold(
      // Display Loading
      body: history.length == 0 ? Center(child: CircularProgressIndicator()) 
      // Display History List
      : SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              floating: false,
              pinned: true,
              snap: false,
              title: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: kDefaultColor,
              flexibleSpace: ReuseFlexSpace(amount),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.white,
                  ),
                  tooltip: 'Add new entry',
                  onPressed: () {/* ... */},
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                _buildList(history, context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
