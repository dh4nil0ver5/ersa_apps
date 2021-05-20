import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  Order({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
    var list_order = ["KMS + DTK","Vandel Album K","Permainan Anak","Perlengkapan PSB"];
    @override
    void initState() {}

    @override
    Widget build(BuildContext context) {
        return new ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: <Widget>[
            new SizedBox(height: 20.0),
            new Container(height:100,decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/doc1.png"),
                fit: BoxFit.cover,
              ),
            ),),
            new SizedBox(height: 20.0),
            new Container(
              child: new ListView.builder(
                shrinkWrap: true,
                itemCount: list_order.length,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return new Column(
                    children: <Widget>[
                      new Container(
                        height: 50.0,
                        color: Colors.green,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Icon(Icons.format_list_numbered,
                                color: Colors.white),
                            new Padding(
                                padding: const EdgeInsets.only(right: 5.0)),
                            new Text(list_order[index],
                                style: new TextStyle(
                                    fontSize: 20.0, color: Colors.white)),
                          ],
                        ),
                      ),
                      new Container(
                        height: 150.0,
                        child: new ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return new Card(
                              elevation: 5.0,
                              child: new Container(
                                height: MediaQuery.of(context).size.width / 3,
                                width: MediaQuery.of(context).size.width / 3,
                                alignment: Alignment.center,
                                child: new Text('Item $index'),
                              ),
                            );
                          },
                        ),
                      ),
                      new SizedBox(height: 20.0),
                    ],
                  );
                },
              ),
            ),
          ],
        );
    }
}
