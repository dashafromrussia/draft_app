import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:untitled/yandex_map/domain/models/map_point.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with TickerProviderStateMixin {

  int amount = 0;
  List<AnimationController> widgets = [];
  List<String> list = const [
    'https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcS0LwZQLiqGHuRp9nw6klCZXhrz_-olb4KmAuDfDRZJfWj1QgyXr2pZ-CyAM8YhUib8JElH97zTtEpP0EULsANwme9Qq1Jlctn1SJdPTA',
    "https://static-cse.canva.com/blob/846514/pexelsvierro3629813.jpg",
    "https://encrypted-tbn2.gstatic.com/licensed-image?q=tbn:ANd9GcQSslEZn6yup0IVIogZvjO1uqpCKVYVPY-i2SXFg7zARRFb3Mlvnq1LIrPilkvAUq-KLOx4ABgO_fsdLDb9hH8iJqkuGw09sDeVxNZRGg",
    'https://lh6.googleusercontent.com/proxy/VSDBMeOlHFia1rVgjtrzdD42kC-HsycxOoAOJ_VCsdrf1eGyS8-438Q3d5ZNb2nr8rNFxLRn6010qqIibO88yCK8tSWGlI9c4nZ4SpC3OuHk_771MhIgkGMUPNdhXZ3ytMcfVc54246Fipdt8_4UvcyhIAcAkKg=w1080-h624-n-k-no',
  ];

  @override
  void initState() {
    list.forEach((element) {
      AnimationController controller =
      AnimationController(vsync: this, duration: Duration(seconds: 4));
      widgets.add(controller);
    });
    startAnimation(0);
    super.initState();
  }

  startAnimation(int amounts) {
    print("amount");
    print(amount);
    widgets[amount].addListener(() {
      setState(() {
        if (widgets[amount].value >= 0.99) {
          if (amount == widgets.length - 1) {
            widgets[amount].stop();
            Navigator.of(context).pop();
            print("END");
            return;
          } else {
            widgets[amount].stop();
            amount++;
            startAnimation(amount);
          }
        }
      });
    });
    widgets[amount].forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widgets.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              child: AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 600,
                  ),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      alwaysIncludeSemantics: true,
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: Image.network(
                    key: ValueKey<int>(amount),
                    list[amount],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  )),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ...widgets.map((e) =>
                        Expanded(child: StoryPage(img: '', animationController: e)))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (amount > 0) {
                            //перепрыг назад в сториз
                            widgets[amount].reset();
                            widgets[amount - 1].reset();
                            amount--;
                            setState(() {});
                            widgets[amount].forward();
                          }
                        },
                        child: Text("<")),
                    ElevatedButton(
                        onPressed: () {
                          //if(amount<widgets.length)
                          widgets[amount].animateTo(1,
                              duration: const Duration(milliseconds: 0));
                        },
                        child: Text(">")),
                  ],
                )
              ],
            )
          ],
        ));
    // StoryPage(img: list[count],);
  }
}

class StoryPage extends StatefulWidget {
  final String img;
  AnimationController animationController;

  StoryPage({required this.img, required this.animationController});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 2,
        padding: const EdgeInsets.symmetric(horizontal: 0.5),
        child: LinearProgressIndicator(
          borderRadius: BorderRadius.circular(2),
          minHeight: 2,
          color: Colors.white,
          backgroundColor: Colors.grey,
          value: widget.animationController.value,
        ));
  }
}

////мод окно при нажатии на иконку на карте
class ModalBodyView extends StatefulWidget {
  const ModalBodyView({required this.point});

  final List<MapPoint> point;

  @override
  State<ModalBodyView> createState() => ModalBodyViewState();
}

class ModalBodyViewState extends State<ModalBodyView>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        lowerBound: 0.6,
        upperBound: 1,
        duration: Duration(seconds: 4))
      ..addListener(() {
        if (_controller.value == 1) _controller.reverse();
        if (_controller.value == 0.6) _controller.forward();
        setState(() {});
      });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child:ListView(children: [
          ...widget.point.map((point) =>
          Column(children: [
                Text(point.name, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                Text(
                  '${point.latitude}, ${point.longitude}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  point.desc,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
               point.img != ''
                    ?
                    Transform.scale(
                        scale: _controller.value,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: OpenContainer(
                              closedColor: Theme.of(context).dialogBackgroundColor,
                              transitionDuration: const Duration(seconds: 2),
                              // transitionType: ContainerTransitionType.fadeThrough,
                              openBuilder: (context, openContainer) =>
                                  StoryScreen(),
                              closedBuilder: (context, openContainer) {
                                return //stack try use
                                  // Hero(
                                  // tag: "tag_story",
                                  // child:
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child:Image.network(
                                        point.img,
                                        height: 200,
                                        width: 500,
                                        fit: BoxFit.cover,
                                      ));
                              },
                            )))

                    : const SizedBox()
              ])
          )
        ],),
    );
  }
}