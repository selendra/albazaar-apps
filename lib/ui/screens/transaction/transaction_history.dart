import 'package:selendra_marketplace_app/all_export.dart';

class TransactionHistory extends StatelessWidget {
  final String title;
  final String amount;
  final String logo;

  TransactionHistory({this.title, this.amount, this.logo});

  List _buildList(
      List<TrxHistoryModel> history, BuildContext context, String userWallet) {
    List<Widget> listItems = List();

    for (int i = 0; i < history.length; i++) {
      listItems.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                await Components.dialog(
                  context,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ItemList(title: "Id", trailing: history[i].id),
                      ItemList(
                        title: "Created At",
                        trailing:
                            AppUtils.timeStampToDateTime(history[i].createdAt),
                      ),
                      ItemList(title: "Sender", trailing: history[i].sender),
                      ItemList(
                          title: "Destination",
                          trailing: history[i].destination),
                      ItemList(
                          title: "Amount",
                          trailing: history[i].amount.toString()),
                      ItemList(
                          title: "Fee", trailing: history[i].fee.toString()),
                      ItemList(title: "Memo", trailing: history[i].memo),
                    ],
                  ),
                  Text(
                    "Transaction history",
                    textAlign: TextAlign.left,
                  ),
                );
              },
              child: Container(
                //margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                height: 60.0,
                color: Colors.white,
                child: ListTile(
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        AppUtils.timeStampToDateTime(history[i].createdAt),
                        style: TextStyle(fontSize: 10.0),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      userWallet == history[i].destination
                          ? Text(
                              '+ ${history[i].amount} SEL',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.green,
                                fontSize: 18.0,
                              ),
                            )
                          : Text(
                              '- ${history[i].amount} SEL',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.red,
                                fontSize: 18.0,
                              ),
                            ),
                    ],
                  ),
                  leading: Image.asset(logo, width: 30, height: 30),
                  title: Text(
                    userWallet == history[i].destination ? 'Recieved' : 'Sent',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 4.0,
            ),
          ],
        ),
      );
    }
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    var history = Provider.of<TrxHistoryProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      // Have No History
      body: history.trxHistoryList == null
          ? SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'images/undraw_wallet.svg',
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.height * 0.2,
                        placeholderBuilder: (context) => Center(),
                      ),
                    ),
                  ),
                ],
              ),
            )

          // Display Loading
          : history.trxHistoryList.length == 0
              ? Center(child: CircularProgressIndicator())
              // Display History List
              : SafeArea(
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.3,
                        floating: false,
                        pinned: true,
                        snap: false,
                        title: Text(
                          title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        ),
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Provider.of<TrxHistoryProvider>(context,
                                    listen: false)
                                .trxHistoryList
                                .clear();
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
                          _buildList(history.trxHistoryList, context,
                              userProvider.mUser.wallet),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
