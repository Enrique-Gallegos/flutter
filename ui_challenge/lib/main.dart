import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Traducción de cartas Tarot',
      theme: ThemeData(
        fontFamily: 'Arial',
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> cards = [
    {
      "image": "lib/imagenes/luna.png",
      "title": "La Luna",
      "description":
          "La Luna es una carta que brinda reflexión, señala inseguridades y dudas. Asimismo, puede traer al presente asuntos del pasado."
    },
    {
      "image": "lib/imagenes/sol.png",
      "title": "El Sol",
      "description":
          "El Sol comprende el éxito y el optimismo, el renacer desde la alegría. Es vista como una carta de mucha energía y con gran potencial."
    },
    {
      "image": "lib/imagenes/estrella.png",
      "title": "La Estrella",
      "description":
          "La Estrella señala el espíritu de juventud, la suerte y las emociones. Está relacionada con la espiritualidad y la fe, la confianza y la esperanza."
    },
    {
      "image": "lib/imagenes/rueda.png",
      "title": "La Rueda de la fortuna",
      "description":
          "La Rueda es el símbolo de los cambios y el destino. Lo que debe ser, lo inevitable y las nuevas oportunidades en la vida."
    },
    {
      "image": "lib/imagenes/emperador.png",
      "title": "El Emperador",
      "description":
          "El Emperador representa el liderazgo, los bienes materiales y el poder. Está relacionado con el posicionamiento social y la estabilidad financiera."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 46, 38, 41),
              Color.fromRGBO(148, 53, 119, 1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tus cartas",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return TarotCard(
                    image: card['image']!,
                    title: card['title']!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            image: card['image']!,
                            title: card['title']!,
                            description: card['description']!,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Falta agregar botón para añadir cartas")),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TarotCard extends StatefulWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const TarotCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  State<TarotCard> createState() => _TarotCardState();
}

class _TarotCardState extends State<TarotCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.9,
      upperBound: 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _controller.reverse(),
      onTapUp: (_) => _controller.forward(),
      onTapCancel: () => _controller.forward(),
      child: AnimatedOpacity(
        opacity: _isTapped ? 0.8 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Hero(
          tag: widget.image,
          child: ScaleTransition(
            scale: _controller,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      widget.image,
                      width: 80,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DetailsPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const DetailsPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de gradiente
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 138, 52, 146),
                  Color.fromARGB(255, 37, 23, 28),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Contenido
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              // Sombra detrás de la carta
              Stack(
                alignment: Alignment.center,
                children: [
                  // Rectángulo oscuro para la sombra
                  Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.only(top: 30),
                  ),
                  // Imagen de la carta
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Hero(
                      tag: image,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: 300, // Tamaño aumentado de la imagen
                        height: 300, // Tamaño aumentado de la imagen
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            image,
                            fit: BoxFit.contain, // Ajuste completo de la imagen
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Título y descripción
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
