import 'package:flutter/material.dart';
import 'package:flutterpaymentgateway/screens/existing_card.dart';
import 'package:flutterpaymentgateway/services/payment_service.dart';
import 'package:progress_dialog/progress_dialog.dart';

class HomePage extends StatefulWidget {
  static const name = "HomePage";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("home page"),
        ),
        body: ListView.separated(
          itemBuilder: (_, index) {
            Icon icon;
            Text text;
            switch (index) {
              case 0:
                icon = Icon(
                  Icons.add_circle,
                  color: theme.primaryColor,
                );
                text = Text("pay via new card");
                break;
              case 1:
                icon = Icon(
                  Icons.credit_card,
                  color: theme.primaryColor,
                );
                text = Text("pay via existing card");
                break;
            }
            return Builder(
              builder: (context) => InkWell(
                child: ListTile(
                  leading: icon,
                  title: text,
                  onTap: () {
                    onItemPress(context, index);
                  },
                ),
              ),
            );
          },
          separatorBuilder: (_, index) => Divider(
            color: theme.primaryColor,
          ),
          itemCount: 2,
        ));
  }

  void onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        final ProgressDialog pr = ProgressDialog(context);
        pr.style(message: 'please wait...');
        await pr.show();

        //change here
        StripeTransactionResponse response = await StripeService.payFromNewCard(
            '15000', 'USD'); // 15000 mean 150.00 dollar

        await pr.hide();
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(response.message),
          duration:
              Duration(milliseconds: response.success == true ? 1200 : 3000),
        ));
        break;
      case 1:
        Navigator.pushNamed(context, ExistingCardPage.name);
        break;
    }
  }
}
