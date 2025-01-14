import 'package:flutter/material.dart';
import 'package:nexi_payment/nexi_payment.dart';
import 'package:nexi_payment/models/currency_utils_qp.dart';
import 'package:nexi_payment/models/environment_utils.dart';
import './second_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  late NexiPayment _nexiPayment;
    static const _secretKey = 'YOUR_SECRET';

  @override
  void initState() {
    super.initState();

    ///domain is not mandatory and it is set to https://ecommerce.nexi.it automatically if empty
    _nexiPayment = NexiPayment(
      secretKey:_secretKey,
      environment: EnvironmentUtils.PROD,
      domain: 'https://ecommerce.nexi.it',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        ElevatedButton(child: const Text('PAY'), onPressed: () => _paga(DateTime.now().millisecondsSinceEpoch.toString())),
        ElevatedButton(
            child: const Text('GO to A SECOND PAGE'),
            onPressed: () => Navigator.push<Widget>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(),
                  ),
                )),
      ])),
    );
  }

  void _paga(String codTrans) async {
    var res = await _nexiPayment.xPayFrontOfficePaga(
      'ALIAS_WEB_023034887',
      codTrans,
      CurrencyUtilsQP.EUR,
      2500,
    );
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
                        'Response',
                        style: TextStyle(fontSize: 22, color: Colors.black38, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text(response, style: TextStyle(color: response == 'OK' ? Colors.green : Colors.red))],
          ),
        );
      },
    );
  }
}
