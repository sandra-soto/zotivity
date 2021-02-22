class UserFeedback extends StatefulWidget {
  final String title;

  @override
  _UserFeedbackState createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<MyHomePage> {
// support function here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("activity feedback"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onPressed: () {
              // navigate to home page WRITE HERE
              Navigator.push(context,MaterialPageRoute(builder: (context) => CalenderPage()));
            },
          )
        ],
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RawMaterialButton(onPressed: () {}, //keep recommendation
              elevation: 2.0,
              fillColor: Colors.lightGreen,
              child: Icon(
                Icons.thumb_up,
                color: Colors.white,
                size: 30.0,
              ),
              padding: EdgeInsets.all(50.0),
              shape: CircleBorder(),),

            RawMaterialButton(onPressed: () {}, //not recommend this activity again
              elevation: 2.0,
              fillColor: Colors.redAccent,
              child: Icon(
                Icons.thumb_down,
                color: Colors.white,
                size: 30.0,
              ),
              padding: EdgeInsets.all(50.0),
              shape: CircleBorder(),),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
