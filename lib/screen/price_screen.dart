import 'dart:convert';

import 'package:clima_weather_app/component/price_card.dart';
import 'package:clima_weather_app/controller/data_controller.dart';
import 'package:clima_weather_app/cubit/cubit/price_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

import '../coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  // double btcPrice = 0;
  // double ethPrice = 0;
  // double ltcPrice = 0;

  List<String> cryptocurrencies = ['BTC', 'ETH', 'LTC'];

  // Create a function to fetch and update data
  Future<void> fetchAndUpdateData(String currency) async {
    try {
      await BlocProvider.of<PriceCubit>(context).fetchPriceData(currency);
      // Update the UI with the new data
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    // Fetch initial data with the default currency

    BlocProvider.of<PriceCubit>(context).fetchPriceData(selectedCurrency);
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
          setState(() async {
            selectedCurrency = value ?? '';

            // Clear the existing data in the modelList
            DataController.modelList.clear();

            // Fetch and update data for the new currency
            fetchAndUpdateData(selectedCurrency);
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
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                BlocBuilder<PriceCubit, PriceState>(builder: (context, state) {
                  if (state is PriceLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is PriceException) {
                    return const Center(child: Text('No Internet'));
                  }

                  if (state is PriceLoaded) {
                    return DataController.modelList.isEmpty
                        ? const Text("Empty")
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: cryptocurrencies.length,
                            itemBuilder: (context, index) {
                              final modelData = DataController.modelList[index];
                              return PriceCard(
                                cryptoName: cryptocurrencies[index],
                                cryptoPrice: modelData.rate,
                                selectedCurrency: selectedCurrency,
                              );
                            },
                          );
                  }
                  return Container();
                }),
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






// Future<void> getExchnageRate() async {
//     final Uri uriBTC = Uri.parse(
//       'https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=F1A1740E-FF20-415F-BE64-77E0B4B09B3B',
//     );
//     final Uri uriETH = Uri.parse(
//       'https://rest.coinapi.io/v1/exchangerate/ETH/$selectedCurrency?apikey=F1A1740E-FF20-415F-BE64-77E0B4B09B3B',
//     );
//     final Uri uriLTC = Uri.parse(
//       'https://rest.coinapi.io/v1/exchangerate/LTC/$selectedCurrency?apikey=F1A1740E-FF20-415F-BE64-77E0B4B09B3B',
//     );
//     final http.Response responseBTC = await http.get(uriBTC);
//     final http.Response responseETH = await http.get(uriETH);
//     final http.Response responseLTC = await http.get(uriLTC);

//     if (responseBTC.statusCode == 200 &&
//         responseETH.statusCode == 200 &&
//         responseLTC.statusCode == 200) {
//       String dataBTC = responseBTC.body;
//       String dataETH = responseETH.body;
//       String dataLTC = responseLTC.body;

//       print(dataBTC);
//       setState(() {
//         btcPrice = jsonDecode(dataBTC)['rate'];
//         ethPrice = jsonDecode(dataETH)['rate'];
//         ltcPrice = jsonDecode(dataLTC)['rate'];
//       });

//       // print(btcPrice);
//     } else {
//       if (kDebugMode) {
//         print(responseBTC.statusCode);
//       }
//     }
//   }
