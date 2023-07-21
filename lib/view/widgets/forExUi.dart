import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';
import 'package:sanathan_nepal_mobile_app/view/helper/styles.dart';

enum ChartView {
  daily,
  weekly,
  monthly,
  yearly,
}

class ForexUI extends StatefulWidget {
  @override
  _ForexUIState createState() => _ForexUIState();
}

class _ForexUIState extends State<ForexUI> {
  String selectedCurrencyFrom = 'USD';
  String selectedCurrencyTo = 'EUR';
  double amountFrom = 0.0;
  double amountTo = 0.0;
  ChartView selectedView = ChartView.daily;

  Map<String, double> exchangeRates = {
    'USD': 1.0,
    'EUR': 0.85,
    'GBP': 0.71,
    'JPY': 110.32,
  };

  List<ExchangeRateData> buyingData = [
    ExchangeRateData(DateTime(2022, 1, 1), 0.85),
    ExchangeRateData(DateTime(2022, 2, 1), 0.87),
    ExchangeRateData(DateTime(2022, 3, 1), 0.86),
    ExchangeRateData(DateTime(2022, 4, 1), 0.84),
    // Add more data points...
  ];

  List<ExchangeRateData> sellingData = [
    ExchangeRateData(DateTime(2022, 1, 1), 0.88),
    ExchangeRateData(DateTime(2022, 2, 1), 0.86),
    ExchangeRateData(DateTime(2022, 3, 1), 0.85),
    ExchangeRateData(DateTime(2022, 4, 1), 0.83),
    // Add more data points...
  ];

  List<charts.Series<ExchangeRateData, DateTime>> generateChartData() {
    List<ExchangeRateData> selectedBuyingData = [];
    List<ExchangeRateData> selectedSellingData = [];

    switch (selectedView) {
      case ChartView.daily:
        selectedBuyingData = buyingData;
        selectedSellingData = sellingData;
        break;
      case ChartView.weekly:
        selectedBuyingData = _aggregateDataByWeek(buyingData);
        selectedSellingData = _aggregateDataByWeek(sellingData);
        break;
      case ChartView.monthly:
        selectedBuyingData = _aggregateDataByMonth(buyingData);
        selectedSellingData = _aggregateDataByMonth(sellingData);
        break;
      case ChartView.yearly:
        selectedBuyingData = _aggregateDataByYear(buyingData);
        selectedSellingData = _aggregateDataByYear(sellingData);
        break;
    }

    // Add today's data point with rounded dots
    DateTime today = DateTime.now();
    double todayBuyingRate = 0.0;
    double todaySellingRate = 0.0;

    // Find today's buying and selling rates
    for (ExchangeRateData data in selectedBuyingData) {
      if (data.date.isAtSameMomentAs(today)) {
        todayBuyingRate = data.rate;
        break;
      }
    }

    for (ExchangeRateData data in selectedSellingData) {
      if (data.date.isAtSameMomentAs(today)) {
        todaySellingRate = data.rate;
        break;
      }
    }

    // Add today's data point
    if (todayBuyingRate != 0.0 && todaySellingRate != 0.0) {
      selectedBuyingData.add(ExchangeRateData(today, todayBuyingRate));
      selectedSellingData.add(ExchangeRateData(today, todaySellingRate));
    }

    return [
      charts.Series<ExchangeRateData, DateTime>(
        id: 'Buying',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ExchangeRateData data, _) => data.date,
        measureFn: (ExchangeRateData data, _) => data.rate,
        data: selectedBuyingData,
      ),
      charts.Series<ExchangeRateData, DateTime>(
        id: 'Selling',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (ExchangeRateData data, _) => data.date,
        measureFn: (ExchangeRateData data, _) => data.rate,
        data: selectedSellingData,
      ),
    ];
  }

  List<ExchangeRateData> _aggregateDataByWeek(List<ExchangeRateData> data) {
    // Perform aggregation logic to group data by week
    // Return the aggregated data as a new list
    return data;
  }

  List<ExchangeRateData> _aggregateDataByMonth(List<ExchangeRateData> data) {
    // Perform aggregation logic to group data by month
    // Return the aggregated data as a new list
    return data;
  }

  List<ExchangeRateData> _aggregateDataByYear(List<ExchangeRateData> data) {
    // Perform aggregation logic to group data by year
    // Return the aggregated data as a new list
    return data;
  }

  void convertCurrency() {
    double rateFrom = exchangeRates[selectedCurrencyFrom]!;
    double rateTo = exchangeRates[selectedCurrencyTo]!;
    amountTo = (amountFrom / rateFrom) * rateTo;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    String getFormattedDate(DateTime date) {
      final nepaliLocale = 'ne_NP';
      final bsFormatter = DateFormat.yMMMMd(nepaliLocale);
      final adFormatter = DateFormat('dd MMMM, yyyy');

      final bsDate = bsFormatter.format(date);
      final adDate = adFormatter.format(date);

      return '$bsDate ($adDate)';
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'Foreign Exchange',
                style: TextStyles.subheading(),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'USD 130.8',
                style: TextStyles.body(),
              ),
              Text(
                'UK 130.8',
                style: TextStyles.body(),
              ),
              const Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.minimize))
            ],
          ),
          Row(
            children: [
              Text(
                'US dollor-TREND',
                style: TextStyles.body(),
              ),
              const SizedBox(width: 20),
              Text(
                getFormattedDate(DateTime.now()),
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),

          // Rest of the UI code...

          const SizedBox(height: 16.0),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<ChartView>(
                    value: selectedView,
                    onChanged: (value) {
                      setState(() {
                        selectedView = value!;
                      });
                    },
                    itemHeight: 50,
                    items: const [
                      DropdownMenuItem(
                        value: ChartView.daily,
                        child: Text('Daily'),
                      ),
                      DropdownMenuItem(
                        value: ChartView.weekly,
                        child: Text('Weekly'),
                      ),
                      DropdownMenuItem(
                        value: ChartView.monthly,
                        child: Text('Monthly'),
                      ),
                      DropdownMenuItem(
                        value: ChartView.yearly,
                        child: Text('Yearly'),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Radio(
                    value: 1,
                    groupValue: 'null',
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Colors.deepOrange),
                    onChanged: (index) {}),
                Text('buy'),
                Radio(
                    value: 1,
                    groupValue: 'null',
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Colors.blue),
                    onChanged: (index) {}),
                Text('Sell'),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: charts.TimeSeriesChart(
              generateChartData(),
              animate: true,
              dateTimeFactory: const charts.LocalDateTimeFactory(),
              primaryMeasureAxis: charts.NumericAxisSpec(
                tickProviderSpec:
                    charts.BasicNumericTickProviderSpec(zeroBound: false),
                tickFormatterSpec:
                    charts.BasicNumericTickFormatterSpec((value) {
                  return '\u{20B9}${value?.toStringAsFixed(2)}';
                }),
              ),
              domainAxis: const charts.DateTimeAxisSpec(
                tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                  day: charts.TimeFormatterSpec(
                    format: 'd',
                    transitionFormat: 'MMM d, yyyy',
                  ),
                  month: charts.TimeFormatterSpec(
                    format: 'MMM',
                    transitionFormat: 'MMM yyyy',
                  ),
                  year: charts.TimeFormatterSpec(
                    format: 'yyyy',
                    transitionFormat: 'yyyy',
                  ),
                ),
              ),
              defaultRenderer: charts.LineRendererConfig(
                includeArea: true,
                stacked: true,
                roundEndCaps: true,
                includePoints: true,
                //symbolRendererFn: (series, _) => CustomSymbolRenderer(),
              ),
              customSeriesRenderers: [
                charts.LineRendererConfig(
                  customRendererId: 'customLine',
                  includeArea: true,
                  stacked: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),

          Card(
            elevation: 4,
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: DropdownButton<String>(
                            value: selectedCurrencyFrom,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCurrencyFrom = newValue!;
                              });
                            },
                            items: exchangeRates.keys
                                .map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 150.0),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            amountFrom = double.tryParse(value) ?? 0.0;
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.0),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: DropdownButton<String>(
                            value: selectedCurrencyTo,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCurrencyTo = newValue!;
                              });
                            },
                            items: exchangeRates.keys
                                .map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Buy',
                          ),
                          onChanged: (value) {},
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'sell',
                          ),
                          onChanged: (value) {},
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Table(
            defaultColumnWidth: const FixedColumnWidth(120.0),
            border: TableBorder.all(
                color: Colors.black, style: BorderStyle.none, width: 1),
            children: [
              TableRow(children: [
                Column(children: [Text('Currency', style: TextStyles.body())]),
                Column(children: [Text('Buy', style: TextStyles.body())]),
                Column(children: [Text('Sell', style: TextStyles.body())]),
              ]),
              TableRow(children: [
                Column(children: [Text(selectedCurrencyTo)]),
                Column(children: [Text('130.05')]),
                Column(children: [Text('131.45')]),
              ]),
            ],
          ),

          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  convertCurrency();
                },
                child: const Text('Convert'),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {}, child: const Text('More currency information')),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Converted Amount:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            '$amountTo $selectedCurrencyTo',
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}

class ExchangeRateData {
  final DateTime date;
  final double rate;

  ExchangeRateData(this.date, this.rate);
}

