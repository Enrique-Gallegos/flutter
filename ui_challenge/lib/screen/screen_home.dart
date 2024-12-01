import 'package:flutter/material.dart';
import '../widget/tarot.dart';
import 'screen_detail.dart';

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
              Color.fromRGBO(148, 53, 119, 1),
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
              content: Text("Falta agregar botón para añadir cartas"),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
