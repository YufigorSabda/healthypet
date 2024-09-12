import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthypet/models/doctor_model.dart';
import 'package:healthypet/models/service_model.dart';
import 'package:healthypet/screens/chat_screen.dart';
import 'package:healthypet/screens/bookmark_screen.dart';
import 'package:healthypet/screens/akun_screen.dart';

var selectedService = 0;
var menus = [
  Icons.home,
  Icons.favorite,
  Icons.message,
  Icons.person,
];
var selectedMenu = 0;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: _bottomNavigationBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              _greetings(context),
              const SizedBox(
                height: 16,
              ),
              _card(),
              const SizedBox(
                height: 20,
              ),
              _search(),
              const SizedBox(
                height: 20,
              ),
              _services(),
              const SizedBox(
                height: 27,
              ),
              _doctors(context),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        selectedItemColor: const Color(0xFF818AF9),
        type: BottomNavigationBarType.fixed,
        items: menus
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(e),
                label: e.toString(),
              ),
            )
            .toList(),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: const Color(0xFFBFBFBF),
      );

  ListView _doctors(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => _doctor(doctors[index], context),
      separatorBuilder: (context, index) => const SizedBox(
        height: 11,
      ),
      itemCount: doctors.length,
    );
  }

  Container _doctor(DoctorModel doctorModel, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF35385A).withOpacity(.12),
            blurRadius: 30,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          _navigateToChatScreen(context, doctorModel);
        },
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                'assets/images/${doctorModel.image}',
                width: 88,
                height: 103,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorModel.name,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3F3E3F),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Service: ${doctorModel.services.join(', ')}",
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.pin_drop,
                        size: 14,
                        color: Color(0xFFACA3A3),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        "${doctorModel.distance}km",
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          color: const Color(0xFFACA3A3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Text(
                        "Available for",
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF50CC98),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset('assets/svgs/cat.svg'),
                      const SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset('assets/svgs/dog.svg'),
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

  void _navigateToChatScreen(BuildContext context, DoctorModel doctorModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(doctorModel: doctorModel),
      ),
    );
  }

  Padding _greetings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Hello, Human!',
            style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF3F3E3F),
            ),
          ),
          IconButton(
            onPressed: () {
              _navigateToAkunScreen(context);
            },
            icon: const Icon(
              Icons.account_circle,
              color: Color(0xFF818AF9),
            ),
          ),
          IconButton(
            onPressed: () {
              _navigateToBookmarkScreen(context);
            },
            icon: const Icon(
              Icons.favorite,
              color: Color(0xFF818AF9),
            ),
          ),
        ],
      ),
    );
  }

  AspectRatio _card() {
    return AspectRatio(
      aspectRatio: 336 / 184,
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xFF818AF9),
        ),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/background_card.png',
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Your ",
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: const Color(0xFFDEE1FE),
                        height: 150 / 100,
                      ),
                      children: const [
                        TextSpan(
                          text: "Catrine ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: "will get\nvaccination "),
                        TextSpan(
                          text: "tomorrow \nat 07.00 am!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      border: Border.all(
                        color: Colors.white.withOpacity(.12),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "See details",
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFFADACAD),
          ),
          hintText: "Find best vaccinate, treatment...",
          hintStyle: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFCACACA),
            height: 150 / 100,
          ),
        ),
      ),
    );
  }

  SizedBox _services() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: selectedService == index
                ? const Color(0xFF818AF9)
                : const Color(0xFFF6F6F6),
            border: selectedService == index
                ? Border.all(
                    color: const Color(0xFFF1E5E5).withOpacity(.22),
                    width: 2,
                  )
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              Service.all()[index],
              style: GoogleFonts.manrope(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: selectedService == index
                    ? Colors.white
                    : const Color(0xFF3F3E3F).withOpacity(.3),
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: Service.all().length,
      ),
    );
  }

  void _navigateToBookmarkScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookmarkScreen()),
    );
  }

  void _navigateToAkunScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AkunScreen()),
    );
  }
}
