import 'package:flutter/material.dart';
import 'history_detail.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<HistoryPage> {
  List items = getDummyList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Aatmarnirbhar Farmer'),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        child: ListView.builder(
          
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(items[index]),
          background: Container(
            alignment: AlignmentDirectional.centerEnd,
            color: Colors.red,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) {
            setState(() {
              items.removeAt(index);
            });
          },
          direction: DismissDirection.endToStart,
          child: Card(
              elevation: 5,
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
              child: Container(
              //height: 150.0,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topLeft: Radius.circular(5)
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("https://crop-protection-network.s3.amazonaws.com/articles/Downy-Mildew-D.-Mueller-15.jpg")
                      )
                    ),
                  ),
                  Container(
                    height: 200,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            items[index],
                            
                          ),
                          Flexible(
                            child:Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 5),
                              child: Container(
                              // width: 260,
                              child: Text("Disease: Tomato_Early_Blight",style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),),
                              
                            ),
                          ),),
                          
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                              child: Container(
                              width: 105,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.teal),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: FlatButton(
                                child: Text("View More",textAlign: TextAlign.justify,style: TextStyle(color: Colors.teal,)),
                                onPressed: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => HistDetail()));
                                 
                                },
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    )),
    );
  }

  static List getDummyList() {
    List list = List.generate(10, (i) {
      return "Crop ${i + 1}";
    });
    return list;
  }
}