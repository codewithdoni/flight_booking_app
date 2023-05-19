import 'package:emirates_airlines_concept_ui/main_pages/add_flight_page_controller.dart';
import 'package:emirates_airlines_concept_ui/sub_pages/checkout_page.dart';
import 'package:emirates_airlines_concept_ui/sub_pages/seat_selection_page.dart';
import 'package:emirates_airlines_concept_ui/widgets/custom_tab_bar/custom_tab_bar.dart';
import 'package:emirates_airlines_concept_ui/widgets/custom_tab_bar/custom_tab_bar_controller.dart';
import 'package:emirates_airlines_concept_ui/widgets/fade_in_out_widget/fade_in_out_widget.dart';
import 'package:emirates_airlines_concept_ui/widgets/fade_in_out_widget/fade_in_out_widget_controller.dart';
import 'package:flutter/material.dart';

import '../sub_pages/available_flights_page.dart';
import '../sub_pages/route_selection_page.dart';
import '../widgets/flights_list_item_widget.dart';

class AddFlightPage extends StatefulWidget {
  final AddFlightPageController addFlightPageController;
  final Function(bool)? isSingleTabSelectionCompleted;
  const AddFlightPage({
    super.key,
    required this.isSingleTabSelectionCompleted,
    required this.addFlightPageController,
  });

  @override
  State<AddFlightPage> createState() => _AddFlightPageState();
}

class _AddFlightPageState extends State<AddFlightPage> {
  late final List<Widget> _pages;
  late final ValueNotifier<int> _pageNotifier;
  late final CustomTabBarController _customTabBarController;
  late final FadeInOutWidgetController _fadeInOutWidgetController;

  @override
  void initState() {
    super.initState();
    _fadeInOutWidgetController = FadeInOutWidgetController();

    _pages = [
      RouteSelectionPage(
        isSelectionCompleted: (isCompleted) =>
            widget.isSingleTabSelectionCompleted?.call(isCompleted),
      ),
      AvailableFlightsPage(
        isSelectionCompleted: (isCompleted) =>
            widget.isSingleTabSelectionCompleted?.call(isCompleted),
      ),
      SeatSelectionPage(
        flightData: FlightData(
          "DBC",
          "Dabaca",
          "MAY 19",
          "ADY",
          "Almedy",
          "KB76",
          "1h 35m",
          "8:35 AM",
        ),
        isSelectionCompleted: (isCompleted) =>
            widget.isSingleTabSelectionCompleted?.call(isCompleted),
      ),
      CheckoutPage(
        flightData: FlightData(
          "DBC",
          "Dabaca",
          "MAY 19",
          "ADY",
          "Almedy",
          "KB76",
          "1h 35m",
          "8:35 AM",
        ),
        isSelectionCompleted: (isCompleted) =>
            widget.isSingleTabSelectionCompleted?.call(isCompleted),
      ),
    ];
    _pageNotifier = ValueNotifier(0);
    _customTabBarController = CustomTabBarController();

    widget.addFlightPageController.customTabBarController =
        _customTabBarController;
    widget.addFlightPageController.pageNotifier = _pageNotifier;
    widget.addFlightPageController.fadeInOutWidgetController =
        _fadeInOutWidgetController;
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          children: [
            CustomTabBar(
              customTabBarController:
                  widget.addFlightPageController.customTabBarController,
            ),
            const SizedBox(
              height: 32.0,
            ),
            Expanded(
              child: FadeInOutWidget(
                slideDuration: const Duration(milliseconds: 500),
                slideEndingOffset: const Offset(0, 0.05),
                fadeInOutWidgetController: _fadeInOutWidgetController,
                child: ValueListenableBuilder(
                  valueListenable: widget.addFlightPageController.pageNotifier,
                  builder: (_, value, __) => _pages[value],
                ),
              ),
            ),
          ],
        ),
      );
}
