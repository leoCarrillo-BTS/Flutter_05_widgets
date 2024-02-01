import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(this.title, this.caption, this.imageUrl);
}

final slides = <SlideInfo>[
  SlideInfo(
      'Busca la comida',
      'Ullamco voluptate aute mollit deserunt cupidatat sunt sit dolor veniam incididunt dolore exercitation laborum. Ipsum Lorem sint labore eiusmod mollit qui labore commodo minim velit amet. Excepteur consectetur proident dolore cillum Lorem. Reprehenderit ullamco proident ullamco laborum duis enim dolor ea sint tempor nulla proident.',
      'assets/images/1.png'),
  SlideInfo(
      'Entrega rápida',
      'Anim nisi cillum proident est sunt laborum deserunt. Exercitation nostrud non dolor deserunt pariatur Lorem. Exercitation ad voluptate est in culpa voluptate tempor anim ex in consequat adipisicing. Sint sint aliquip do velit eiusmod. Fugiat ea aliquip proident velit pariatur ut sit. Aute ad minim tempor est amet voluptate ipsum duis.',
      'assets/images/2.png'),
  SlideInfo(
      'Disfruta la comida',
      'In laboris aliqua cillum quis nisi fugiat id elit deserunt. Sunt dolore aliquip mollit esse labore ut magna dolor Lorem amet ipsum. Veniam nisi anim magna magna occaecat labore anim aute. Ad ea commodo in tempor mollit laboris. Ad minim irure sint adipisicing.',
      'assets/images/3.png'),
];

class AppToturialScreen extends StatefulWidget {
  static const name = 'tutorial_screen';

  const AppToturialScreen({super.key});

  @override
  State<AppToturialScreen> createState() => _AppToturialScreenState();
}

class _AppToturialScreenState extends State<AppToturialScreen> {
  final PageController pageViewController = PageController();
  bool endReached = false;

  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() {
      final page = pageViewController.page ?? 0;

      if (!endReached && page >= (slides.length - 1.5)) {
        setState(() {
          endReached = true;
        });
      }
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageViewController,
            physics: const BouncingScrollPhysics(),
            children: slides
                .map((data) => _Slide(
                    title: data.title,
                    caption: data.caption,
                    imageUrl: data.imageUrl))
                .toList(),
          ),
          Positioned(
              right: 8,
              top: 32,
              child: TextButton(
                  onPressed: () => context.pop(), child: const Text('Salir'))),
          endReached
              ? Positioned(
                  bottom: 8,
                  right: 8,
                  child: FadeInRight(
                    from: 15,
                    delay: const Duration(seconds: 1),
                    child: FilledButton(
                        onPressed: () => context.pop(),
                        child: const Text('Empezar')),
                  ))
              : const SizedBox(),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String imageUrl;

  const _Slide(
      {required this.title, required this.caption, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(imageUrl)),
            const SizedBox(
              height: 22,
            ),
            Text(
              title,
              style: titleStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              caption,
              style: captionStyle,
            ),
          ],
        ),
      ),
    );
  }
}
