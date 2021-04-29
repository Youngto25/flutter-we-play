import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PintuanItem extends StatefulWidget {
  var item;
  PintuanItem({Key key, this.item}) : super(key: key);

  @override
  _PintuanItemState createState() => _PintuanItemState(this.item);
}

class _PintuanItemState extends State<PintuanItem> {
  var item;
  _PintuanItemState(this.item);

  String _toString(double price) {
    return price.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(4)),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(204, 204, 204, 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: FadeInImage.assetNetwork(
                  placeholder: "images/task_invite.jpg",
                  image: this.item["picUrl"],
                  fit: BoxFit.cover,
                ),
              ),
              height: 100,
              width: 100,
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: '10',
                                style: Theme.of(context).textTheme.bodyText2),
                            TextSpan(
                                text: '人开团，拼中',
                                style: Theme.of(context).textTheme.bodyText1),
                            TextSpan(
                                text: '1',
                                style: Theme.of(context).textTheme.bodyText2),
                            TextSpan(
                                text: '人,未拼中全额退款，没人再得',
                                style: Theme.of(context).textTheme.bodyText1),
                            TextSpan(
                                text: '0.10',
                                style: Theme.of(context).textTheme.bodyText2),
                            TextSpan(
                                text: '元',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            // this._toString(),
                            this.item["name"],
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(width: 10),
                          Text(
                            this._toString(this.item["price"]),
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 31, 57, 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                          child: Text('赚',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0)))),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: this
                                              ._toString(this.item["rebate"]),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2),
                                      TextSpan(
                                          text: '元/次',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1)
                                    ]),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                          width: 80,
                                          height: 10,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: LinearProgressIndicator(
                                                backgroundColor: Color.fromRGBO(
                                                    251, 128, 128, 1),
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Color.fromRGBO(
                                                            255, 31, 57, 1)),
                                                value: 0.2,
                                              ))),
                                      Container(
                                        child: Text('60%',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white)),
                                        width: 80,
                                        height: 10,
                                        alignment: Alignment.center,
                                      )
                                    ],
                                  ),
                                  Text('正在参团', style: TextStyle(fontSize: 9))
                                ],
                              ),
                            ],
                          )),
                          // Expanded(
                          Container(
                              height: 30,
                              width: 75,
                              child: RaisedButton(
                                color: Color.fromRGBO(255, 31, 57, 1),
                                child: Center(
                                  child: Text('立即拼团',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color.fromRGBO(
                                              255, 255, 255, 1))),
                                ),
                                onPressed: () {},
                              )),
                        ],
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}
