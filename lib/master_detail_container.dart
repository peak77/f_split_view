
import 'package:f_split_view/item.dart';
import 'package:f_split_view/item_details.dart';
import 'package:f_split_view/item_listing.dart';
import 'package:f_split_view/new_page.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:f_split_view/h_route.dart' as Custom;

class MasterDetailContainer extends StatefulWidget {
  @override
  _ItemMasterDetailContainerState createState() =>
      _ItemMasterDetailContainerState();
}

class _ItemMasterDetailContainerState extends State<MasterDetailContainer> {
  static const int kTabletBreakpoint = 600;

  Item _selectedItem;

  Widget _buildMobileLayout() {
    return ItemListing(
      itemSelectedCallback: (item) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ItemDetails(
                isInTabletLayout: false,
                item: item,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Material(
            child: ItemListing(
              itemSelectedCallback: (item) {
                setState(() {
                  _selectedItem = item;
                });
              },
              selectedItem: _selectedItem,
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Navigator(
            initialRoute: 'signup/personal_info',
            onGenerateRoute: (RouteSettings settings) {
              WidgetBuilder builder;
              switch (settings.name) {
                case 'signup/personal_info':
                  // Assume CollectPersonalInfoPage collects personal info and then
                  // navigates to 'signup/choose_credentials'.
                  builder = (BuildContext context) => ItemDetails(
                        isInTabletLayout: true,
                        item: _selectedItem,
                      );
                  break;
                case 'signup/choose_credentials':
                  // Assume ChooseCredentialsPage collects new credentials and then
                  // invokes 'onSignupComplete()'.
                  final args = settings.arguments as Map;
                  builder = (BuildContext _) => NewPage(title: args['title'],);
                  break;
                default:
                  throw Exception('Invalid route: ${settings.name}');
              }
              return Custom.CupertinoPageRoute<void>(
                  builder: builder, settings: settings);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileLayout();
    } else {
      content = _buildTabletLayout();
    }
    return Material(child: content,);
  }
}