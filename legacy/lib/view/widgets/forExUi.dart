import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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

  /// Series shown in the trend chart for the currently selected [ChartView].
  ({List<ExchangeRateData> buying, List<ExchangeRateData> selling})
      generateChartData() {
    List<ExchangeRateData> selectedBuyingData;
    List<ExchangeRateData> selectedSellingData;

    switch (selectedView) {
      case ChartView.daily:
        selectedBuyingData = List.of(buyingData);
        selectedSellingData = List.of(sellingData);
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

    // Add today's data point (if present in the source data).
    final DateTime today = DateTime.now();
    double todayBuyingRate = 0.0;
    double todaySellingRate = 0.0;

    for (final ExchangeRateData data in selectedBuyingData) {
      if (data.date.isAtSameMomentAs(today)) {
        todayBuyingRate = data.rate;
        break;
      }
    }
    for (final ExchangeRateData data in selectedSellingData) {
      if (data.date.isAtSameMomentAs(today)) {
        todaySellingRate = data.rate;
        break;
      }
    }
    if (todayBuyingRate != 0.0 && todaySellingRate != 0.0) {
      selectedBuyingData.add(ExchangeRateData(today, todayBuyingRate));
      selectedSellingData.add(ExchangeRateData(today, todaySellingRate));
    }

    return (buying: selectedBuyingData, selling: selectedSellingData);
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
              Flexible(
                child: Text(
                  'Foreign Exchange',
                  style: TextStyles.subheading(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  'USD 130.8  UK 130.8',
                  style: TextStyles.body(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.minimize))
            ],
          ),
          Row(
            children: [
              Text(
                'US dollor-TREND',
                style: TextStyles.body(),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  getFormattedDate(DateTime.now()),
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
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
            child: Builder(
              builder: (context) {
                final series = generateChartData();
                return _ForexTrendChart(
                  buying: series.buying,
                  selling: series.selling,
                );
              },
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

/// Buy/sell exchange-rate trend rendered with `fl_chart`.
///
/// Replaces the discontinued `charts_flutter` TimeSeriesChart: two lines with
/// area fill and point markers, date-formatted x-axis, currency-formatted
/// y-axis (not zero-bound) and a touch tooltip.
class _ForexTrendChart extends StatelessWidget {
  const _ForexTrendChart({required this.buying, required this.selling});

  final List<ExchangeRateData> buying;
  final List<ExchangeRateData> selling;

  static const Color _buyColor = Color(0xFF1E88E5); // blue 600
  static const Color _sellColor = Color(0xFFE64A19); // deep orange 700

  static double _x(DateTime d) => d.millisecondsSinceEpoch.toDouble();

  static DateTime _date(double x) =>
      DateTime.fromMillisecondsSinceEpoch(x.round());

  List<FlSpot> _spots(List<ExchangeRateData> data) {
    final sorted = List<ExchangeRateData>.of(data)
      ..sort((a, b) => a.date.compareTo(b.date));
    return [for (final d in sorted) FlSpot(_x(d.date), d.rate)];
  }

  static String _formatRate(double value) =>
      '\u{20B9}${value.toStringAsFixed(2)}';

  LineChartBarData _line(List<FlSpot> spots, Color color) => LineChartBarData(
        spots: spots,
        color: color,
        barWidth: 2,
        isCurved: false,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
            radius: 4,
            color: color,
            strokeWidth: 2,
            strokeColor: Colors.white,
          ),
        ),
        belowBarData: BarAreaData(
          show: true,
          color: color.withValues(alpha: 0.12),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final buySpots = _spots(buying);
    final sellSpots = _spots(selling);
    final all = [...buySpots, ...sellSpots];

    if (all.isEmpty) {
      return const Center(child: Text('No exchange-rate data'));
    }

    final minY = all.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    final maxY = all.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    final pad = (maxY - minY) == 0 ? (maxY.abs() * 0.05 + 0.01) : (maxY - minY) * 0.15;

    final minX = all.map((s) => s.x).reduce((a, b) => a < b ? a : b);
    final maxX = all.map((s) => s.x).reduce((a, b) => a > b ? a : b);
    final spanDays = _date(maxX).difference(_date(minX)).inDays;
    final DateFormat axisFormat = spanDays > 365
        ? DateFormat('yyyy')
        : spanDays > 60
            ? DateFormat('MMM')
            : DateFormat('d MMM');
    final labelStyle = Theme.of(context).textTheme.bodySmall;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            _LegendDot(color: _buyColor, label: 'Buying'),
            SizedBox(width: 12),
            _LegendDot(color: _sellColor, label: 'Selling'),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: LineChart(
            LineChartData(
              minY: minY - pad,
              maxY: maxY + pad,
              minX: minX,
              maxX: maxX,
              clipData: const FlClipData.none(),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (_) => FlLine(
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.4),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 56,
                    getTitlesWidget: (value, meta) => SideTitleWidget(
                      meta: meta,
                      child: Text(_formatRate(value), style: labelStyle),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    interval: maxX == minX ? 1 : (maxX - minX) / 3,
                    getTitlesWidget: (value, meta) => SideTitleWidget(
                      meta: meta,
                      child: Text(axisFormat.format(_date(value)),
                          style: labelStyle),
                    ),
                  ),
                ),
              ),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) => [
                    for (final spot in touchedSpots)
                      LineTooltipItem(
                        '${spot.barIndex == 0 ? 'Buy' : 'Sell'} '
                        '${_formatRate(spot.y)}\n'
                        '${DateFormat('d MMM yyyy').format(_date(spot.x))}',
                        TextStyle(
                          color: spot.bar.color ?? Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
              lineBarsData: [
                _line(buySpots, _buyColor),
                _line(sellSpots, _sellColor),
              ],
            ),
            duration: const Duration(milliseconds: 250),
          ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
