import 'package:flutter/material.dart';
import 'package:mylamsy/controller/booking_meals_api.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';
import 'item_details.dart';
import 'package:easy_localization/easy_localization.dart';
class SearchBarScreen extends SearchDelegate {
  BookingMeal bookingMeal = BookingMeal();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var locale=context.locale;
    return FutureBuilder(
      future: bookingMeal.getMealsBySearch(query,locale),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (!snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: CircularProgressIndicator()),
            ],
          );
        } else if (snapshot.data.length == 0) {
          return Column(
            children: <Widget>[
              Text(
                LocaleKeys.no_result.tr(),
              ),
            ],
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              var result = snapshot.data[index];
              return ListTile(
                contentPadding: EdgeInsets.all(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ItemDetails(snapshot.data[index])),
                  );
                },
                title: Text(
                  snapshot.data[index]["name"],
                  style: TextStyle(
                      fontSize: 20,
                      color: CustomColors.SecondaryHover,
                      fontWeight: FontWeight.bold),
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Center(
      child: Container(
        child: Text(LocaleKeys.wait.tr()),
      ),
    );
  }
}
