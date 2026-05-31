import 'package:flutter/material.dart';

class Catalogo extends StatefulWidget {
  const Catalogo({super.key});

  @override
  State<Catalogo> createState() => _CatalogoState();
}

class _CatalogoState extends State<Catalogo> {
  String categoriaSeleccionada = "Cafés";

  final List<String> categorias = [
    "Cafés",
    "Frappés",
    "Postres",
    "Tés",
    "Servicios",
  ];

  final List<Map<String, String>> productos = [
    {
      "imagen": "imagenes/americano.png",
      "nombre": "Café Americano",
      "precio": "\$35",
      "descripcion":
          "Café negro tradicional preparado con espresso y agua caliente.",
      "categoria": "Cafés",
    },
    {
      "imagen": "imagenes/capuccino.png",
      "nombre": "Cappuccino",
      "precio": "\$55",
      "descripcion": "Espresso con leche vaporizada y espuma cremosa.",
      "categoria": "Cafés",
    },
    {
      "imagen": "imagenes/oreo.jpg",
      "nombre": "Frappé Oreo",
      "precio": "\$75",
      "descripcion": "Bebida fría con hielo, leche y galleta Oreo triturada.",
      "categoria": "Frappés",
    },
    {
      "imagen": "imagenes/chessecake.jpg",
      "nombre": "Cheesecake",
      "precio": "\$70",
      "descripcion":
          "Pastel de queso suave con base de galleta y cobertura dulce.",
      "categoria": "Postres",
    },
    {
      "imagen": "imagenes/teverde.jpg",
      "nombre": "Té Verde",
      "precio": "\$40",
      "descripcion":
          "Infusión natural de hojas de té verde con un sabor suave y refrescante.",
      "categoria": "Tés",
    },
    {
      "imagen": "imagenes/eventos.jpg",
      "nombre": "Reserva de Espacio",
      "precio": "\$150",
      "descripcion":
          "Servicio de reservación para reuniones y eventos pequeños.",
      "categoria": "Servicios",
    },
  ];

  final List<Map<String, String>> carrito = [];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> productosFiltrados = productos.where((producto) {
      return producto["categoria"] == categoriaSeleccionada;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A5F),
        centerTitle: true,

        title: const Text(
          "Catálogo de Productos",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Colors.white,

            onPressed: () {
              int total = 0;

              for (var producto in carrito) {
                total += int.parse(producto["precio"]!.replaceAll("\$", ""));
              }
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Carrito"),

                    content: SizedBox(
                      width: double.maxFinite,

                      child: carrito.isEmpty
                          ? const Text("No hay productos seleccionados.")
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: carrito.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(carrito[index]["nombre"]!),
                                      subtitle: Text(carrito[index]["precio"]!),
                                    );
                                  },
                                ),

                                const Divider(),

                                Text(
                                  "Total: \$${total}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),

                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cerrar"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Seleccione una categoría",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),

              decoration: BoxDecoration(
                color: const Color(0xFF334155),
                borderRadius: BorderRadius.circular(15),
              ),

              child: DropdownButton<String>(
                value: categoriaSeleccionada,
                isExpanded: true,
                dropdownColor: const Color(0xFF334155),
                underline: const SizedBox(),

                style: const TextStyle(color: Colors.white, fontSize: 16),

                items: categorias.map((String categoria) {
                  return DropdownMenuItem<String>(
                    value: categoria,
                    child: Text(
                      categoria,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),

                onChanged: (String? nuevaCategoria) {
                  setState(() {
                    categoriaSeleccionada = nuevaCategoria!;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Categoría seleccionada: $categoriaSeleccionada",
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            Text(
              "Categoría actual: $categoriaSeleccionada",
              style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 16),
            ),

            const SizedBox(height: 25),

            const Text(
              "Productos Disponibles",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: productosFiltrados.length,

              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),

                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(15),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),

                          child: Container(
                            height: 220,
                            width: double.infinity,
                            color: Colors.white,
                            padding: const EdgeInsets.all(10),

                            child: Image.asset(
                              productosFiltrados[index]["imagen"]!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          productosFiltrados[index]["nombre"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          productosFiltrados[index]["precio"]!,
                          style: const TextStyle(
                            color: Color(0xFFCBD5E1),
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          productosFiltrados[index]["descripcion"]!,
                          style: const TextStyle(
                            color: Color(0xFFCBD5E1),
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 15),

                        SizedBox(
                          width: double.infinity,

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                            ),

                            onPressed: () {
                              setState(() {
                                carrito.add(productosFiltrados[index]);
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "${productosFiltrados[index]["nombre"]} agregado al carrito",
                                  ),
                                ),
                              );
                            },

                            child: const Text(
                              "Seleccionar",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
