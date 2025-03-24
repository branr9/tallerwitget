import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Lista con los nombres de los procesos del ciclo de vida
  List<String> lifecycleSteps = [
    "Creación de Widget",
    "Inicialización (initState)",
    "Dependencias (didChangeDependencies)",
    "Construcción de UI (build)",
    "Actualización de Estado (setState)",
    "Destrucción (dispose)"
  ];

  // Lista de iconos representativos para cada proceso
  List<IconData> lifecycleIcons = [
    Icons.add_box, // Creación de Widget
    Icons.play_circle_fill, // initState
    Icons.sync, // didChangeDependencies
    Icons.build, // build
    Icons.refresh, // setState
    Icons.delete_forever, // dispose
  ];

  @override
  void initState() {
    super.initState();
    print("initState ejecutado"); // Se ejecuta al crear el widget
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies ejecutado"); // Se ejecuta cuando cambian dependencias
  }

  @override
  Widget build(BuildContext context) {
    print("build ejecutado"); // Se ejecuta cada vez que se reconstruye la UI
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.grid_on), text: "GridView"),
            Tab(icon: Icon(Icons.list), text: "Lista"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2,
            ),
            itemCount: lifecycleSteps.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(lifecycleIcons[index], size: 40, color: Colors.purple), // Ícono representativo
                    SizedBox(height: 10),
                    Text(
                      lifecycleSteps[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          ),
          ListView.builder(
            itemCount: lifecycleSteps.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(lifecycleIcons[index], color: Colors.purple), // Ícono representativo
                title: Text(lifecycleSteps[index]),
                onTap: () {
                  context.go('/detail/${lifecycleSteps[index]}');
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            print("setState ejecutado"); // Se ejecuta cuando hay un cambio en el estado
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    print("dispose ejecutado"); // Se ejecuta al destruir el widget
    super.dispose();
  }
}
