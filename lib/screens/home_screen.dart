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
    Icons.add_box,
    Icons.play_circle_fill,
    Icons.sync,
    Icons.build,
    Icons.refresh,
    Icons.delete_forever,
  ];

  // NUEVAS FUNCIONALIDADES DEL TALLER
  List<String> featureTitles = [
    "Lista de Estudiantes",
    "Contador (Timer)",
    "Tarea Pesada (Isolate)",
  ];

  List<IconData> featureIcons = [
    Icons.people,
    Icons.timer,
    Icons.memory,
  ];

  List<String> featureRoutes = [
    "/students",
    "/counter",
    "/heavy-task",
  ];

  @override
  void initState() {
    super.initState();
    print("initState ejecutado");
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies ejecutado");
  }

  @override
  Widget build(BuildContext context) {
    print("build ejecutado");

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
          // GRIDVIEW
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2,
            ),
            itemCount: lifecycleSteps.length + featureTitles.length,
            itemBuilder: (context, index) {
              if (index < lifecycleSteps.length) {
                // Tarjetas del ciclo de vida
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(lifecycleIcons[index], size: 40, color: Colors.purple),
                      SizedBox(height: 10),
                      Text(
                        lifecycleSteps[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              } else {
                // Tarjetas de funcionalidades del taller
                final featureIndex = index - lifecycleSteps.length;
                return GestureDetector(
                  onTap: () {
                    context.go(featureRoutes[featureIndex]);
                  },
                  child: Card(
                    color: Colors.grey.shade100,
                    margin: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(featureIcons[featureIndex], size: 40, color: Colors.deepPurple),
                        SizedBox(height: 10),
                        Text(
                          featureTitles[featureIndex],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),

          // LISTVIEW (detalle de ciclo de vida)
          ListView.builder(
            itemCount: lifecycleSteps.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(lifecycleIcons[index], color: Colors.purple),
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
            print("setState ejecutado");
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    print("dispose ejecutado");
    super.dispose();
  }
}
