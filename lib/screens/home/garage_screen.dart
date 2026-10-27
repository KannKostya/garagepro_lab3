import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../main_screen.dart';

class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key});

  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

				backgroundColor: Colors.transparent,
				
        title: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Image.asset(
                  'assets/images/Logo.png',
                  width: 32,
                  height: 32
                ),
                
                const SizedBox(width: 8),

                const Text('GaragePro',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
                ),

              ],
            ),

            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap:() => {
                  MainScreen.of(context)?.setIndex(3),
                },

                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF03192A),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              ),
            ),

          ],
        ),

				flexibleSpace: Container(
					decoration: BoxDecoration(
						color: Colors.white,
						boxShadow: [
							BoxShadow(
								color: Color.fromARGB(4, 0, 0, 0),
								offset: const Offset(0, 1),
								blurRadius: 8,
							),
						]
					)
				),
      ),

      backgroundColor: const Color.fromARGB(255, 247, 249, 252),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Garage',
                      style: TextStyle(
                        color: Color(0xFF03192A),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Text(
                      '3 vehicles currently registered',
                      style: TextStyle(
                        color: Color(0xFF43474C),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    MainScreen.of(context)?.setIndex(2);
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 17,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Add Car',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF03192A),
                    elevation: 4,
                    shadowColor: Color.fromARGB(10, 0, 0, 0),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: const StadiumBorder(),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            
            //Volkswagen Tigua container
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(6, 0, 0, 0),
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
              
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/car1.png',
                        width: 96,
                        height: 80,
                      ),

                      const SizedBox(width: 16),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(
                            width: 214,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Volkswagen Tigua',
                                  style: TextStyle(
                                    color: Color(0xFF03192A),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),

                                  decoration: BoxDecoration(
                                    color: Color(0xFFAFD2FD),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Text(
                                    'Active',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF375A7F),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Text(
                            'Compact SUV • All-Wheel Drive',
                            style: TextStyle(
                              color: Color(0xFF43474C),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),

                          Row(
                            children: [

                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),

                                decoration: BoxDecoration(
                                  color: Color(0xFFECEEF1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'AB-1234-CE',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF03192A),
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),

                              Icon(
                                Icons.speed_outlined,
                                size: 12,
                                color: Color(0xFF43474C),
                              ),


                              const Text(
                                '145,000 km',
                                style: TextStyle(
                                  color: Color(0xFF43474C),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFE6E8EB),
                          width: 1,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 15,
                              color: Color(0xFFD38033),
                            ),
                            const Text(
                              'Service due in 500 km',
                              style: TextStyle(
                                color: Color(0xFFD38033),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap:() => {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                                  ),
                                },

                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFECEEF1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.edit_outlined,
                                    color: Color(0xFF191C1E),
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 4),

                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap:() => {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Car succesfully deleted!')),
                                  )
                                },

                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFDAD6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Color(0xFFBA1A1A),
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 16),

            //Honda Civic container
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(6, 0, 0, 0),
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
              
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/car2.png',
                        width: 96,
                        height: 80,
                      ),

                      const SizedBox(width: 16),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(
                            width: 214,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Honda Civic',
                                  style: TextStyle(
                                    color: Color(0xFF03192A),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),

                                  decoration: BoxDecoration(
                                    color: Color(0xFFECEEF1),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Text(
                                    'Idle',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF43474C),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Text(
                            'Sedan • 4-Cylinder',
                            style: TextStyle(
                              color: Color(0xFF43474C),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),

                          Row(
                            children: [

                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),

                                decoration: BoxDecoration(
                                  color: Color(0xFFECEEF1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'BA-9876-AB',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF03192A),
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),

                              Icon(
                                Icons.speed_outlined,
                                size: 12,
                                color: Color(0xFF43474C),
                              ),


                              const Text(
                                '52,100 km',
                                style: TextStyle(
                                  color: Color(0xFF43474C),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFE6E8EB),
                          width: 1,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 15,
                              color: Color(0xFF03192A),
                            ),
                            const Text(
                              'Inspected last month',
                              style: TextStyle(
                                color: Color(0xFF03192A),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap:() => {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                                  ),
                                },

                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFECEEF1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.edit_outlined,
                                    color: Color(0xFF191C1E),
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 4),

                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap:() => {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Car succesfully deleted!')),
                                  )
                                },

                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFDAD6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Color(0xFFBA1A1A),
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 16),

            //BMW 3 Series container
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(6, 0, 0, 0),
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
              
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/car3.png',
                        width: 96,
                        height: 80,
                      ),

                      const SizedBox(width: 16),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(
                            width: 214,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'BMW 3 Series',
                                  style: TextStyle(
                                    color: Color(0xFF03192A),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),

                                  decoration: BoxDecoration(
                                    color: Color(0xFFAFD2FD),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Text(
                                    'Active',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF375A7F),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Text(
                            'Sports Sedan • TwinPower Turbo',
                            style: TextStyle(
                              color: Color(0xFF43474C),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),

                          Row(
                            children: [

                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),

                                decoration: BoxDecoration(
                                  color: Color(0xFFECEEF1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'BM-1234-MB',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF03192A),
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),

                              Icon(
                                Icons.speed_outlined,
                                size: 12,
                                color: Color(0xFF43474C),
                              ),


                              const Text(
                                '108,300 km',
                                style: TextStyle(
                                  color: Color(0xFF43474C),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFE6E8EB),
                          width: 1,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 15,
                              color: Color(0xFF03192A),
                            ),
                            const Text(
                              'Inspected last month',
                              style: TextStyle(
                                color: Color(0xFF03192A),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap:() => {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                                  ),
                                },

                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFECEEF1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.edit_outlined,
                                    color: Color(0xFF191C1E),
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 4),

                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap:() => {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Car succesfully deleted!')),
                                  )
                                },

                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFDAD6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Color(0xFFBA1A1A),
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              
              decoration: BoxDecoration(
                color: Color(0xFFF2F4F7),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE2E7EC),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lightbulb_outline,
                      color: Color(0xFF03192A),
                      size: 20,
                    ),
                  ),

                  const SizedBox(width: 24),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        'Garage Tip',
                        style: TextStyle(
                          color: Color(0xFF03192A),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),

                      const Text(
                        'Keep your mileage up to date to get precise oil',
                        style: TextStyle(
                          color: Color(0xFF43474C),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),

                      const Text(
                        'change forecasts.',
                        style: TextStyle(
                          color: Color(0xFF43474C),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}