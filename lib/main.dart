import 'package:flutter/material.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sudoku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Sudoku"),
          ),
          body: const MyHomePage()),
    );
  } 
}
//statefulwidget عشان البيانات عندي مو ثابتة stf
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //احولها للست عادية عشان اوصل لها عن طريق الاندكس
  List displaygrid = List.generate(81, (i) => 0);
  // املأ الdisplaygrid في القيم الموجودة في newsodoku اللي جاية من الباكج نفسها
  List<List<int>> newsudoku = [
    // [1, 2, 3],
    // [1, 2, 3],
    // [1, 2, 3]
  ];
  List<List<int>> solvedsudoku = [];
  sudokuGen() {
    var sudokuGenerator = SudokuGenerator(emptySquares: 54);
    // SudokuUtilities.printSudoku(sudokuGenerator.newSudoku);
    //new يحط لي فيها نسخة جديد من سودوكو // grid random number يخزنهم في الليست الجديد newsudoku
    newsudoku = sudokuGenerator.newSudoku;
    // مليتها بالقيم اللي جاية من الباكج
    var index = 0;
    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
        displaygrid[index] = newsudoku[i][j];
        index++;
      }
    }

    print('-------------------------');
    SudokuUtilities.printSudoku(sudokuGenerator.newSudokuSolved);
    solvedsudoku = sudokuGenerator.newSudokuSolved;
  }

  @override
  Widget build(BuildContext context) {
    //scafold ترسم لي الصفحة و احط داخلها الاشياء اللي ابي ارسمها
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            //grid
            child: GridView.builder(
              itemCount: 81,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              // عشان تقفل لي القريد فيو على قد العناصر اللي فيها عشان ما يصير error UI
              // من خصائص gridviwe
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                // احدد العناصر اللي في الوضع الافقي ب 9
                crossAxisCount: 9,
              ),
              itemBuilder: ((context, index) {
                return GestureDetector(
                  // عشان اوفر خاصية ال on tap
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          content: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                displaygrid[index] = value;
                              });
                            },
                            onSubmitted: (value) {
                              setState(() {
                                displaygrid[index] = value;
                              });
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('ok'),
                            ),
                          ],
                        );
                      }),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${displaygrid[index]}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      sudokuGen();
                    });
                  },
                  child: const Text('New Game'),
                ),
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      sudokuGen();
                    });
                  },
                  child: const Text('Check'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
