
import 'package:chillmate/models/recipe.dart';
import 'package:chillmate/screen/searchForPlan.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MealPlan extends StatefulWidget {
  const MealPlan({Key? key, this.animationController}) : super(key: key);
  final AnimationController? animationController;

  @override
  _MealPlanState createState() => _MealPlanState();
}

class _MealPlanState extends State<MealPlan> {
  int count = 9;

  late DateTime _selectedDateAppBBar;

  late TextEditingController controller;
  String cal = '';

  List<Menu> listRecipeBreakfast = [
    Menu(
      recipe: Recipe(
        recipeID: "89ecfbd8-1de2-46f2-a0b3-42bde09c42ce",
        recipeName: "ผัดวุ้นเส้น",
        category: ["อาหารไทย"],
        method:
            "STEp 1:นำวุ้นเส้นไปแช่น้ำ ทิ้งไว้ประมาณ 15 นาที จากนั้นจึงนำมาสะเด็ดน้ำให้แห้ง แล้วพักไว้ STEP 2:ตั้งกระทะใส่น้ำมัน แล้วเปิดไฟกลาง รอจนน้ำมันร้อนจึงใส่กระเทียม ตามด้วยหมูและหอมใหญ่ลงไปผัดจนหมูเกือบสุก STEP 3:จากนั้นใส่ไข่ไก่ลงไป ใช้ตะหลิวเขี่ยไข่แดงให้แตกทิ้งไว้สักพัก พอไข่เริ่มสุกใส่วุ้นเส้น มะเขือเทศ กะหล่ำปลี และต้นหอมลงไปผัดต่อจนสุก ปรุงรสและผัดจนส่วนผสมทั้งหมดเข้ากันดี พร้อมจัดเสิร์ฟ",
        cookingTime: 45,
        image: "c0b611acf5252dfb8b20c0ca1e4888fe.png",
        colorie: 114.205,
        usernameID: UsernameID(
          userID: "4230306d-5601-46cb-8e66-135843c4c24b",
          userName: "Thanakrit",
          name: "ธนกฤต ศิริชัย",
          email: "kittykan0808@gmail.com",
          password: "123456",
          image: "asset/img/profile/1709691439741-new.jpg",
          timeAT: "2024-03-05T05:46:51.276Z",
          interest: null,
          allogre: null,
          role: 1,
        ),
        ingredients: [
          Ingredients(
            ingredientsID: "1c0cd49b-87e8-465a-8404-03772c070e79",
            amount: 15,
            rawMaterial: RawMaterial(
              rawMaterialID: "080a067a-4c8c-4743-80c4-9ac5a7432713",
              amount: 34,
              nameing: "ต้นหอม",
            ),
          ),
        ],
        ratings: [],
      ),
      rate: 0,
    ),
  ];
  List<Menu> listRecipeLunch = [];
  List<Menu> listRecipeDinner = [];

  late DateTime _selectedValue;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _selectedDateAppBBar = DateTime.now();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          margin: const EdgeInsets.only(
            top: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 12,
                ),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CHILLMATE',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => print("Notification"),
                      child: SvgPicture.asset(
                        "assets/icons/notifications.svg",
                        height: 32.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: media.width * 0.05,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DatePicker(
                    DateTime.now().subtract(
                      Duration(days: DateTime.now().weekday),
                    ),
                    width: 60,
                    height: 90,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.amber,
                    selectedTextColor: Colors.white,
                    daysCount: 7,
                    onDateChange: (date) {
                      // New date selected
                      setState(() {
                        _selectedValue = date;
                      });
                      print(_selectedValue);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: media.width,
                          height: media.width * 0.1,
                          margin: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          //color: Colors.amber,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "อาหารเช้า",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: media.width * 0.1,
                                    height: media.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SearchForPlan()),
                                      );
                                    },
                                    icon: Icon(Icons.add),
                                    color: Colors.amber,
                                    iconSize: 23,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: listRecipeBreakfast.length == 0
                              ? Center(
                                  child: Text(
                                    "ยังไม่ได้เลือกสูตรอาหาร",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: listRecipeBreakfast.length,
                                  itemBuilder: (context, index) {
                                    Menu breakfastRecipe =
                                        listRecipeBreakfast[index];

                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color(0xFFFFFCED)),
                                          child: ListTile(
                                            title: detailRecipe(
                                                RecomRecipe: breakfastRecipe),
                                            leading: Image.asset(
                                              "assets/images/salad.png",
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                        ),

                        SizedBox(
                          height: media.width * 0.05,
                        ),
                        Container(
                          width: media.width,
                          height: media.width * 0.1,
                          margin: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "อาหารเที่ยง",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: media.width * 0.1,
                                    height: media.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.add),
                                    color: Colors.amber,
                                    iconSize: 23,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: listRecipeLunch.length == 0
                              ? Center(
                                  child: Text(
                                    "ยังไม่ได้เลือกสูตรอาหาร",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: listRecipeLunch.length,
                                  itemBuilder: (context, index) {
                                    Menu lunchRecipe = listRecipeLunch[index];

                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color(0xFFFFFCED)),
                                          child: ListTile(
                                            title: detailRecipe(
                                                RecomRecipe: lunchRecipe),
                                            leading: Image.asset(
                                              "assets/images/salad.png",
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                        ),
                        SizedBox(
                          height: media.width * 0.05,
                        ),
                        Container(
                          width: media.width,
                          height: media.width * 0.1,
                          margin: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                  
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "อาหารเย็น",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: media.width * 0.1,
                                    height: media.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.add),
                                    color: Colors.amber,
                                    iconSize: 23,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: listRecipeDinner.length == 0
                              ? Center(
                                  child: Text(
                                    "ยังไม่ได้เลือกสูตรอาหาร",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: listRecipeDinner.length,
                                  itemBuilder: (context, index) {
                                    Menu dinnerRecipe = listRecipeDinner[index];

                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color(0xFFFFFCED)),
                                          child: ListTile(
                                            title: detailRecipe(
                                                RecomRecipe: dinnerRecipe),
                                            leading: Image.asset(
                                              "assets/images/salad.png",
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                        ),
                      ],
                    ),
                  )
              
                ],
              ),
            
            ],
          ),
        ),

      ),
    );
  }

  Future<String?> openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('ใส่ปริมาณแคลอรี่'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'แคลอรี่'),
            controller: controller,
            onSubmitted: (_) => submit(),
          ),
          actions: [
            TextButton(
              onPressed: submit,
              child: Text('ยืนยัน'),
            ),
          ],
        ),
      );

  void submit() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
  }
}

class detailRecipe extends StatelessWidget {
  const detailRecipe({
    super.key,
    required this.RecomRecipe,
  });

  final Menu RecomRecipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '${RecomRecipe.recipe?.recipeName ?? ""}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: Colors.black,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '${RecomRecipe.recipe?.cookingTime ?? ""}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              Text(
                ' นาที',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.local_fire_department_outlined,
                color: Colors.black,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '${RecomRecipe.recipe?.colorie ?? ""}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              Text(
                ' แคลอรี',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}