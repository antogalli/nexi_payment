import 'package:flutter/material.dart';
import 'package:nexi_payment/models/currency_utils_qp.dart';
import 'package:nexi_payment/models/environment_utils.dart';
import 'package:nexi_payment/nexi_payment.dart';

class SecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  late NexiPayment _nexiPayment;
  static const _secretKey = 'YOUR_SECRET';
  @override
  void initState() {
    super.initState();
    _nexiPayment = NexiPayment(
      secretKey: _secretKey,
      environment: EnvironmentUtils.PROD,
      domain: ''
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        ElevatedButton(child: Text("PAY"), onPressed: () => _paga("insert_cod_trans41")),
      ])),
    );
  }

  void _paga(String codTrans) async {
    var res = await _nexiPayment.xPayFrontOfficePaga(_secretKey, codTrans, CurrencyUtilsQP.EUR, 2502);
    openEndPaymentDialog(res);
  }

  openEndPaymentDialog(String response) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext c2) {
        return AlertDialog(
          title: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: -12,
                    left: -15,
                    child: IconButton(icon: Icon(Icons.arrow_back), color: Colors.blueAccent, onPressed: () => Navigator.of(context).pop()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.euro_symbol,
                          color: Colors.black38,
                          size: 25,
                        ),
                      ),
                      Text(
                        "Response",
                        style: TextStyle(fontSize: 22, color: Colors.black38, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text(response, style: TextStyle(color: response == "OK" ? Colors.green : Colors.red))],
          ),
        );
      },
    );
  }
}
