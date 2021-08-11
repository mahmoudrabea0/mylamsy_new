import 'package:flutter/material.dart';
import 'package:mylamsy/controller/order_api.dart';
import 'package:mylamsy/style/SimilarWidgets.dart';
import 'package:mylamsy/style/theme.dart';

class MealOrderScreen extends StatefulWidget {
  @override
  _MealOrderScreenState createState() => _MealOrderScreenState();
}

class _MealOrderScreenState extends State<MealOrderScreen> {
  AllOrdersApi allOrdersApi = AllOrdersApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.GrayBack,
      body: FutureBuilder(
        future: allOrdersApi.getordersOfSinglecustomer(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return emptyPage(context);
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ));
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                return Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, pos) {
                      return itemContainer(context, snapshot.data[pos]);
                    },
                  ),
                );
              }
              return emptyPage(context);
              break;
          }
          return emptyPage(context);
        },
      ),
    );
  }

  Widget itemContainer(BuildContext context, Map map) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        map["order_key"],
                        style: TextStyle(
                            fontSize: 20,
                            color: CustomColors.SecondaryHover,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Center(
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: CustomColors.PrimaryHover),
                              ),
                              child: RaisedButton(
                                elevation: 0,
                                onPressed: () {},
                                color: Colors.white,
                                child: Text(
                                  'اعرض الطلب',
                                  style: TextStyle(color: CustomColors.Primary),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: <Widget>[
                              Text(
                                map["total"].toString(),
                                style: TextStyle(
                                    fontSize: 18, color: CustomColors.Primary),
                              ),
                              Text(
                                ' : قيمة الطلب ',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
