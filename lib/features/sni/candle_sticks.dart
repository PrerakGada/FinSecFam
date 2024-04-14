import 'dart:async';
import 'dart:convert';

import 'package:finsec/utils/palette.dart';
import 'package:http/http.dart' as http;
import 'package:candlesticks/candlesticks.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finsec/logic/models/candle_stick_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_table/flutter_expandable_table.dart';

class CandleSticks extends StatefulWidget {
  const CandleSticks({Key? key, required this.code, required this.name}) : super(key: key);
  final String code, name;

  @override
  State<CandleSticks> createState() => _CandleSticksState();
}

class _CandleSticksState extends State<CandleSticks> {
  late Chart futureStock;
  late Timer timer;
  late double regularMarketPrice = 0;
  String selectedRange = "1d", selectedInterval = "1m";
  late List<DropdownMenuItem<String>> ranges = [];
  bool stockIsReady = false;

  Future<Chart?> fetchChart(String code, String range, String interval) async {
    String url =
        "https://query1.finance.yahoo.com/v8/finance/chart/$code?region=IN&lang=en-US&comparisons=&includePrePost=false&interval=$interval&useYfid=true&range=$range&corsDomain=finance.yahoo.com&.tsrc=finance";
    print(
        "https://query1.finance.yahoo.com/v8/finance/chart/$code?region=IN&lang=en-US&comparisons=&includePrePost=false&interval=$interval&useYfid=true&range=$range&corsDomain=finance.yahoo.com&.tsrc=finance");
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Chart.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  @override
  void initState() {
    fetchChart("${widget.code}", "1d", "1m").then((value) {
      if (value != null) {
        futureStock = value;
        ranges = List<DropdownMenuItem<String>>.generate(
          futureStock.validRanges.length,
          (index) => DropdownMenuItem(
            child: Text(futureStock.validRanges[index]),
          ),
        );

        setState(() {
          stockIsReady = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: Container(
          child: stockIsReady
              ? chartCreater(futureStock)
              : Center(
                  child: CircularProgressIndicator(color: Palette.white),
                ),
        ),
      ),
    );
  }

  Widget chartCreater(Chart futureStock) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.9,
      height: 240,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: candleStickCreater(futureStock.timestamp.reversed.toList(), futureStock.open.reversed.toList(), futureStock.close.reversed.toList(), futureStock.high.reversed.toList(),
            futureStock.low.reversed.toList(), futureStock.volume.reversed.toList()),
      ),
    );
  }

  Candlesticks candleStickCreater(
    List<dynamic> timestamp,
    List<dynamic> open,
    List<dynamic> close,
    List<dynamic> high,
    List<dynamic> low,
    List<dynamic> volume,
  ) {
    late List<double> newOpen, newClose, newHigh, newLow, newVolume;
    late List<DateTime> newTimestamp;

    double getPreviousFinite(int index, List<dynamic> list) {
      while (list[index] == null) {
        if (index == 0) break;
        index--;
      }

      if (index == 0 && list[index] == null) {
        while (list[index] == null) {
          if (index == list.length - 1) break;
          index++;
        }
      }
      return double.parse(list[index].toString());
    }

    newTimestamp = List<DateTime>.generate(timestamp.length, (index) {
      return timestamp[index] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(timestamp[index] * 1000);
    });
    newOpen = List<double>.generate(open.length, (index) {
      return open[index] == null ? getPreviousFinite(index, open) : double.parse(open[index].toString());
    });
    newClose = List<double>.generate(close.length, (index) {
      return close[index] == null ? getPreviousFinite(index, close) : double.parse(close[index].toString());
    });
    newHigh = List<double>.generate(close.length, (index) {
      return close[index] == null ? getPreviousFinite(index, high) : double.parse(close[index].toString());
    });
    newLow = List<double>.generate(close.length, (index) {
      return low[index] == null ? getPreviousFinite(index, low) : double.parse(low[index].toString());
    });
    newVolume = List<double>.generate(volume.length, (index) {
      return volume[index] == null ? getPreviousFinite(index, volume) : double.parse(volume[index].toString());
    });

    return Candlesticks(
        candles: List<Candle>.generate(
            newTimestamp.length, (index) => Candle(date: newTimestamp[index], high: newHigh[index], low: newLow[index], open: newOpen[index], close: newClose[index], volume: newVolume[index])));
  }

  Widget setRegularMarketPrice(Chart futureStock) {
    var current = futureStock.regularMarketPrice;
    var previousClose = futureStock.chartPreviousClose;
    Color color = Theme.of(context).primaryColorDark;
    String sign = "";

    if (current > regularMarketPrice) {
      color = Colors.greenAccent;
    } else if (current < regularMarketPrice) {
      sign = "-";
      color = Colors.redAccent;
    }
    regularMarketPrice = futureStock.regularMarketPrice;
    return Row(
      children: [
        Text(
          "$current",
          style: TextStyle(color: color, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 20),
        Text(
          sign + (current - previousClose).toStringAsFixed(2),
          style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Text(
          "($sign${(100 - previousClose / current * 100).toStringAsFixed(2)}%)",
          style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget rangeCreater(String title, bool forRange, List<DropdownMenuItem<String>> validRanges) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Text(
          "$title:    ",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        // DropdownButton2(
        //   value: forRange ? selectedRange : selectedInterval,
        //   onChanged: (value) {
        //     setState(() {
        //       if (forRange) {
        //         selectedRange = value!;
        //       } else {
        //         selectedInterval = value!;
        //       }
        //       callStock();
        //     });
        //   },
        //   items: validRanges,
        // )
      ],
    );
  }
}

const Color primaryColor = Color(0xFF1e2f36); //corner
const Color accentColor = Color(0xFF0d2026); //background
const TextStyle textStyle = TextStyle(color: Colors.white);
const TextStyle textStyleSubItems = TextStyle(color: Colors.grey);

ExpandableTable buildExpandableTable() {
  const int col = 6;
  // const int subCol = 5;
  const int row = 6;

  //Creation header
  // ExpandableTableHeader subHeader = ExpandableTableHeader(
  //     firstCell: Container(
  //         color: primaryColor,
  //         margin: const EdgeInsets.all(1),
  //         child: const Center(
  //             child: Text(
  //           'Expandable Column',
  //           style: textStyleSubItems,
  //         ))),
  //     children: List.generate(
  //         SUB_COLUMN_COUNT,
  //         (index) => Container(
  //             color: primaryColor,
  //             margin: const EdgeInsets.all(1),
  //             child: Center(
  //                 child: Text(
  //               'Sub Column $index',
  //               style: textStyleSubItems,
  //             )))));

  //Creation header
  ExpandableTableHeader header = ExpandableTableHeader(
    cell: ExpandableTableCell(
      child: Container(
          color: primaryColor,
          margin: const EdgeInsets.all(1),
          child: const Center(
              child: Text(
            'Breakdown',
            style: textStyle,
          ))),
    ),
    children: List.generate(
      col - 1,
      (index) => ExpandableTableHeader(
        cell: ExpandableTableCell(
          child: Container(
            color: primaryColor,
            margin: const EdgeInsets.all(1),
            child: Center(
              child: Text(
                'Column $index',
                style: textStyle,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  //Creation sub rows
  // List<ExpandableTableRow> subTows1 = List.generate(
  //     row,
  //     (rowIndex) => ExpandableTableRow(
  //           height: 10,
  //           firstCell: Container(
  //               color: primaryColor,
  //               margin: const EdgeInsets.all(1),
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 16.0),
  //                 child: Text(
  //                   'Sub Sub Row $rowIndex',
  //                   style: textStyleSubItems,
  //                 ),
  //               )),
  //           children: List<Widget>.generate(
  //               col - 1,
  //               (columnIndex) => Container(
  //                   color: primaryColor,
  //                   margin: const EdgeInsets.all(1),
  //                   child: Center(
  //                       child: Text(
  //                     'Cell $rowIndex:$columnIndex',
  //                     style: textStyleSubItems,
  //                   )))),
  //         ));
  List<ExpandableTableRow> subRows = List.generate(
      row,
      (rowIndex) => ExpandableTableRow(
            height: 50,
            firstCell: ExpandableTableCell(
              child: Container(
                  color: primaryColor,
                  margin: const EdgeInsets.all(1),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Sub Row $rowIndex',
                        style: textStyleSubItems,
                      ),
                    ),
                  )),
            ),
            children: List<ExpandableTableRow>.generate(
                col - 1,
                (columnIndex) => ExpandableTableRow(
                      firstCell: ExpandableTableCell(
                        child: Container(
                            color: primaryColor,
                            margin: const EdgeInsets.all(1),
                            child: Center(
                                child: Text(
                              'Cell $rowIndex:$columnIndex',
                              style: textStyleSubItems,
                            ))),
                      ),
                    )),
          ));
  //Creation rows
  List<ExpandableTableRow> rows = List.generate(
      row,
      (rowIndex) => ExpandableTableRow(
            height: 50,
            firstCell: ExpandableTableCell(
              child: Container(
                  color: primaryColor,
                  margin: const EdgeInsets.all(1),
                  child: Center(
                      child: Text(
                    'Row $rowIndex',
                    style: textStyle,
                  ))),
            ),
            legend: rowIndex == 0
                ? Container(
                    color: primaryColor,
                    margin: const EdgeInsets.all(1),
                    child: const Center(
                      child: Text(
                        'Expandible Row...',
                        style: textStyle,
                      ),
                    ),
                  )
                : null,
            children: rowIndex == 0
                ? subRows
                : List<ExpandableTableRow>.generate(
                    col - 1,
                    (columnIndex) => ExpandableTableRow(
                          firstCell: ExpandableTableCell(
                            child: Container(
                                color: primaryColor,
                                margin: const EdgeInsets.all(1),
                                child: Center(
                                    child: Text(
                                  'Cell $rowIndex:$columnIndex',
                                  style: textStyle,
                                ))),
                          ),
                        )),
          ));

  return ExpandableTable(
    headerHeight: 80,
    rows: rows,
    headers: [header],
    scrollShadowColor: accentColor,
  );
}
