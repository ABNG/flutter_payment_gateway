import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutterpaymentgateway/services/payment_service.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ExistingCardPage extends StatefulWidget {
  static const name = "ExistingPage";
  @override
  _ExistingCardState createState() => _ExistingCardState();
}

class _ExistingCardState extends State<ExistingCardPage> {
  List cards = [
    {
      'cardNumber': '4242424242424242',
      'expiryDate': '05/30',
      'cardHolderName': 'abu bakar',
      'cvvCode': '554',
      'showBackView': false, //true when you want to show cvv(back) view
    },
    {
      'cardNumber': '5555555555554444',
      'expiryDate': '06/30',
      'cardHolderName': 'abu bakar nawaz',
      'cvvCode': '555',
      'showBackView': false, //true when you want to show cvv(back) view
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("existing card page"),
        ),
        body: ListView.builder(
          itemBuilder: (_, index) {
            var card = cards[index];
            return Builder(
              builder: (context) => InkWell(
                onTap: () {
                  payViaExistingCard(context, card);
                },
                child: CreditCardWidget(
                  cardNumber: card['cardNumber'],
                  expiryDate: card['expiryDate'],
                  cardHolderName: card['cardHolderName'],
                  cvvCode: card['cvvCode'],
                  showBackView:
                      false, //true when you want to show cvv(back) view
                ),
              ),
            );
          },
          itemCount: cards.length,
        ));
  }

  void payViaExistingCard(BuildContext context, dynamic card) async {
    final ProgressDialog pr = ProgressDialog(context);
    pr.style(message: 'please wait...');
    await pr.show();
    var expireArr = card['expiryDate'].split('/');
    CreditCard creditCard = CreditCard(
      number: card['cardNumber'],
      expMonth: int.parse(expireArr[0]),
      expYear: int.parse(expireArr[1]),
    );
    //change here
    StripeTransactionResponse response =
        await StripeService.payViaExistingCard('2500', 'USD', creditCard);
    await pr.hide();
    Scaffold.of(context)
        .showSnackBar(SnackBar(
          content: Text(response.message),
          duration: Duration(milliseconds: 1200),
        ))
        .closed
        .then((_) => Navigator.pop(context));
  }
}
