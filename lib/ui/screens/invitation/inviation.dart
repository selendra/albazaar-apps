import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/ui/screens/invitation/body_invitation.dart';

class Invitation extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InvitationState();
  }
}

class InvitationState extends State<Invitation> {

  Widget build(BuildContext context){
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(
        //AppLocalizeService.of(context).translate('invitation'), 
        "Invitation",
        context,
      ),
      body: BodyScaffold(
        bottom: 0,
        physics: NeverScrollableScrollPhysics(),
        height: MediaQuery.of(context).size.height,
        child: InviteBody(),
      ),
    );
  }
}