import 'package:flutter/material.dart';
import 'catalogo.dart';

void main() {
  runApp(const MyApp());
}

// ================= APP PRINCIPAL =================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catálogo',
      home: const LoginScreen(),
    );
  }
}

// ================= LOGIN =================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController txtCorreoController = TextEditingController();

  final TextEditingController txtPasswordController = TextEditingController();

  String mensajeCorreo = "";
  bool mostrarAyudaCorreo = false;

  @override
  void dispose() {
    txtCorreoController.dispose();
    txtPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F172A), Color(0xFF1E3A5F), Color(0xFF334155)],
          ),
        ),

        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Container(
                    key: const Key("imgLogo"),

                    width: 240,
                    height: 240,

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(30),

                      border: Border.all(color: Colors.white12, width: 1.5),

                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 18,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(15),

                      child: Image.asset(
                        'imagenes/image.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Bienvenido de nuevo",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Ingresa tus datos para continuar",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),

                  const SizedBox(height: 35),

                  Container(
                    padding: const EdgeInsets.all(25),

                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B).withOpacity(0.88),

                      borderRadius: BorderRadius.circular(28),

                      border: Border.all(color: Colors.white10, width: 1),

                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        // CORREO
                        TextField(
                          key: const Key("txtCorreo"),

                          controller: txtCorreoController,

                          onTap: () {
                            setState(() {
                              mostrarAyudaCorreo = true;
                            });
                          },

                          keyboardType: TextInputType.emailAddress,

                          style: const TextStyle(color: Colors.white),

                          decoration: InputDecoration(
                            hintText: "Correo electrónico",

                            hintStyle: const TextStyle(
                              color: Color(0xFF94A3B8),
                            ),

                            filled: true,

                            fillColor: const Color(0xFF334155),

                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xFFCBD5E1),
                            ),

                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18,
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: const BorderSide(
                                color: Color(0xFF2563EB),
                                width: 2,
                              ),
                            ),
                          ),
                        ),

                        // MENSAJE DE AYUDA
                        if (mostrarAyudaCorreo)
                          const Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 4),
                            child: Text(
                              "Ejemplo válido: usuario@gmail.com",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ),

                        // MENSAJE DE ERROR
                        if (mensajeCorreo.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 8),
                            child: Text(
                              mensajeCorreo,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        const SizedBox(height: 20),
                        // PASSWORD
                        TextField(
                          key: const Key("txtPassword"),

                          controller: txtPasswordController,

                          obscureText: true,

                          style: const TextStyle(color: Colors.white),

                          decoration: InputDecoration(
                            hintText: "Contraseña",

                            hintStyle: const TextStyle(
                              color: Color(0xFF94A3B8),
                            ),

                            filled: true,

                            fillColor: const Color(0xFF334155),

                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Color(0xFFCBD5E1),
                            ),

                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18,
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),

                              borderSide: BorderSide.none,
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),

                              borderSide: const BorderSide(
                                color: Color(0xFF2563EB),
                                width: 2,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 35),

                        SizedBox(
                          width: double.infinity,
                          height: 58,

                          child: ElevatedButton(
                            key: const Key("btnIngresar"),

                            onPressed: () {
                              String correo = txtCorreoController.text.trim();

                              String password = txtPasswordController.text
                                  .trim();

                              if (correo.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Por favor complete todos los campos",
                                    ),
                                  ),
                                );
                                return;
                              }

                              if (!correo.contains("@")) {
                                setState(() {
                                  mensajeCorreo = "El correo debe contener @";
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Correo inválido"),
                                  ),
                                );

                                return;
                              }

                              // LIMPIAR ERROR SI YA ES CORRECTO
                              setState(() {
                                mensajeCorreo = "";
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "¡Bienvenido! Iniciando sesión...",
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );

                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Catalogo(),
                                  ),
                                );
                              });
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),

                              foregroundColor: Colors.white,

                              elevation: 8,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),

                            child: const Text(
                              "INGRESAR",

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 35),

                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Términos y Condiciones"),

                            content: const SingleChildScrollView(
                              child: Text(
                                "Al utilizar esta aplicación, el usuario acepta hacer un uso responsable del sistema. "
                                "La información proporcionada durante el inicio de sesión será utilizada únicamente "
                                "para fines académicos y de demostración. El acceso al catálogo de productos está "
                                "destinado exclusivamente para consulta y prueba de funcionalidades.",
                              ),
                            ),

                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Aceptar"),
                              ),
                            ],
                          );
                        },
                      );
                    },

                    child: const Text(
                      "Términos y condiciones",
                      key: Key("txtTerminos"),

                      style: TextStyle(
                        color: Color(0xFFCBD5E1),
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
