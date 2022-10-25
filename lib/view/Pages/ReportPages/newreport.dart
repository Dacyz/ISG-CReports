import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../System/ProfileConstant.dart';

class newreport extends StatefulWidget {
  @override
  State<newreport> createState() => _newreportState();
}

class _newreportState extends State<newreport> {
  bool isVisible1 = false;
  bool isVisible2 = false;
  bool isVisible3 = false;
  bool value1 = false;
  int _groupValue = 7;
  int _disable = 6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //UiAppbar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            "assets/images/logooficial2.png",
            height: 30,
            width: 40,
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Nuevo Reporte", style: TextStyle(color: Colors.black))
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.brightness_medium_outlined,
              color: Color(0xFFF27900),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //titulo Categorías
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Estado de Avance",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                //SizedBox(width: 12,),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible1 = !isVisible1;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            Visibility(
              visible: isVisible1,
              maintainState: true,
              child: Container(
                width: double.infinity,
                height: 125,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    radiocategorias("Entrega de Materiales", 1),
                    radiocategorias("Ubicación y limpieza de terreno", 2),
                    radiocategorias(
                        "Trazo y excavación de zanjas para cimiento", 3),
                    radiocategorias("Armado de columnas", 4),
                    radiocategorias("Vaciado de cimientos", 5),
                    radiocategorias("Armado y vaciado de sobrecimiento", 6),
                    radiocategorias("Asentado de ladrillos", 7),
                    radiocategorias("Vaciado de Columna", 8),
                    radiocategorias("Acero de techo y encofrado", 9),
                  ],
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "CheckList",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible2 = !isVisible2;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            //Checklist
            Visibility(
              visible: isVisible2,
              maintainState: true,
              child: Container(
                width: double.infinity,
                height: 140,
                child: ListView(
                  children: [
                    checkbox(namepregunta: "Se encontraba el Beneficiario"),
                    checkbox(namepregunta: "Se encontraba el maestro a cargo"),
                    checkbox(namepregunta: "Se encontraban obreros trabajando"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),

            //Titulo Observacion
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Observación",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible3 = !isVisible3;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            //Observacion
            Visibility(
              visible: isVisible3,
              maintainState: true,
              child: Card(
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 5,
                      keyboardType: TextInputType.multiline, //or null
                      decoration: InputDecoration.collapsed(
                          hintText: "Ingresa tu observación aquí"),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(200)
                      ],
                    ),
                  )),
            ),
            const SizedBox(height: defaultPadding),
            //Boton siguiente
            Center(
              child: Container(
                child: ElevatedButton(
                  onPressed: () {
                    _showMessageDialog(context);
                  },
                  child: const Text("Siguiente",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF1E88E5),
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 14),
                    side: BorderSide(color: Color(0xFF084460)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    shadowColor: Colors.lightBlue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  radiocategorias(String title, int index) {
    return Container(
      width: 120,
      child: Card(
        color: index > _disable ? Colors.white : Colors.white54,
        child: Column(
          children: [
            Radio(
              value: index,
              groupValue: _groupValue,
              onChanged: (newValue) {
                setState(() {
                  if (index > _disable) {
                    _groupValue = newValue!;
                  }
                });
              },
            ),
            Expanded(
                child: Text(
              title,
              textAlign: TextAlign.center,
            ))
          ],
        ),
      ),
    );
  }

  checkbox({required String namepregunta}) {
    return Row(
      children: [
        Transform.scale(
          scale: 1,
          child: Checkbox(
            hoverColor: Color(0xFF1E88E5),
            focusColor: Color(0xFFF27900),
            activeColor: Color(0xFFF27900),
            value: value1,
            onChanged: (value) {
              this.value1 = value!;
              (context as Element).markNeedsBuild();
            },
          ),
        ),
        Text(namepregunta),
      ],
    );
  }

  _showMessageDialog(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text("Seguir a cámara"),
          content: Text("¿Esta seguro que quiere continuar?"),
          actions: [
            /*
            TextButton(
              
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen())),
              child: Text("Sí"),
            ),*/
            TextButton(
              onPressed: () => Navigator.of(context).pop("Cancel"),
              child: Text("No"),
            )
          ],
        ),
      );
}
