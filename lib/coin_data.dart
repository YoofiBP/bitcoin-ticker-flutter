import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

Map<String, int> initializeCryptoMap() {
  Map<String, int> cryptoMap = Map();
  cryptoList.forEach((element) {
    cryptoMap[element] = 0;
  });
  return cryptoMap;
}

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '92D75523-B013-4CB8-B4A6-A6704DD611D9';

class CoinData {
  Map<String, int> getCoinData(String selectedCurrency) {
    Map<String, int> cryptoMap = initializeCryptoMap();
    cryptoList.forEach((crypto) async {
      String requestURL =
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        cryptoMap[crypto] = decodedData['rate'].toInt() ?? 0;
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    });

    return cryptoMap;
  }
}
