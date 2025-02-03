/////////Don't use this code it is exmple code 
import 'package:vibeshr/untils/export_file.dart';

class AnimatedCards extends StatefulWidget {
  @override
  _AnimatedCardsState createState() => _AnimatedCardsState();
}

class _AnimatedCardsState extends  State<AnimatedCards>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
/////////Don't use this code it is exmple code 
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
/////////Don't use this code it is exmple code 
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
/////////Don't use this code it is exmple code 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Animation Demo'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildCard(Colors.blue, 'Card 1'),
            buildCard(Colors.red, 'Card 2'),
          ],
        ),
      ),
    );
  }
/////////Don't use this code it is exmple code 
  Widget buildCard(Color color, String text) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.scale(
            scale: 1 - _animation.value,
            child: Card(
              color: color,
              elevation: 5.0,
              child: Container(
                width: 200,
                height: 200,
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
/////////Don't use this code it is exmple code 
class TweenAnimatedCards extends StatelessWidget {
  final double positionX;
  final Color color;

  TweenAnimatedCards({required this.positionX, required this.color});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(positionX, 0.0),
      child: CardWidget(color: color),
    );
  }
}

class CardWidget extends StatelessWidget {
  final Color color;

  CardWidget({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 150.0,
      color: color,
    );
  }
}
/////////Don't use this code it is exmple code 