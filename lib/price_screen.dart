import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  double btcPrice = 0;
  double ethPrice = 0;
  double ltcPrice = 0;

  @override
  void initState() {
    super.initState();
    getExchnageRate();
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownMenu = [];

    for (String currency in currenciesList) {
      dropdownMenu.add(DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
      ));
    }

    return DropdownButton(
        items: dropdownMenu,
        value: selectedCurrency,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value ?? '';
            getExchnageRate();
          });
        });
  }

  CupertinoPicker iosPicker() {
    List<Widget> currencyItems = [];

    for (String currency in currenciesList) {
      currencyItems.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (slectedIndex) {
        print(slectedIndex);
      },
      children: currencyItems,
    );
  }

  Future<void> getExchnageRate() async {
    final Uri uriBTC = Uri.parse(
      'https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=F1A1740E-FF20-415F-BE64-77E0B4B09B3B',
    );
    final Uri uriETH = Uri.parse(
      'https://rest.coinapi.io/v1/exchangerate/ETH/$selectedCurrency?apikey=F1A1740E-FF20-415F-BE64-77E0B4B09B3B',
    );
    final Uri uriLTC = Uri.parse(
      'https://rest.coinapi.io/v1/exchangerate/LTC/$selectedCurrency?apikey=F1A1740E-FF20-415F-BE64-77E0B4B09B3B',
    );
    final http.Response responseBTC = await http.get(uriBTC);
    final http.Response responseETH = await http.get(uriETH);
    final http.Response responseLTC = await http.get(uriLTC);

    if (responseBTC.statusCode == 200 &&
        responseETH.statusCode == 200 &&
        responseLTC.statusCode == 200) {
      String dataBTC = responseBTC.body;
      String dataETH = responseETH.body;
      String dataLTC = responseLTC.body;

      print(dataBTC);
      setState(() {
        btcPrice = jsonDecode(dataBTC)['rate'];
        ethPrice = jsonDecode(dataETH)['rate'];
        ltcPrice = jsonDecode(dataLTC)['rate'];
      });

      // print(btcPrice);
    } else {
      if (kDebugMode) {
        print(responseBTC.statusCode);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Center(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       getExchnageRate();
          //       print('button is clicked');
          //     },
          //     child: const Text('get data'),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                PriceCard(
                  cryptoName: 'BTC',
                  cryptoPrice: btcPrice,
                  selectedCurrency: selectedCurrency,
                ),
                PriceCard(
                  cryptoName: 'ETH',
                  cryptoPrice: ethPrice,
                  selectedCurrency: selectedCurrency,
                ),
                PriceCard(
                  cryptoName: 'LTC',
                  cryptoPrice: ltcPrice,
                  selectedCurrency: selectedCurrency,
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class PriceCard extends StatelessWidget {
  const PriceCard({
    super.key,
    required this.cryptoName,
    required this.cryptoPrice,
    required this.selectedCurrency,
  });

  final double cryptoPrice;
  final String selectedCurrency;
  final String cryptoName;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '$cryptoName = ${cryptoPrice.toInt()} $selectedCurrency',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
