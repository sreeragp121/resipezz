import 'package:flutter/material.dart';
import 'package:recipizz/pages/other/user/aboutus/about_us_main.dart';
import 'package:recipizz/pages/other/user/myprofile/my_profile_main.dart';
import 'package:recipizz/pages/other/user/userpassword/user_pass_main.dart';
import 'package:recipizz/pages/other/user/userrecipeaddpage/user_recipe_add_main.dart';
import 'package:recipizz/pages/tabs/usertabs/menu/Menumain/menu_signout.dart';
import 'package:recipizz/pages/tabs/usertabs/menu/Menumain/menu_userprofile.dart';
import 'package:recipizz/utils/app_theme.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

final List<Menuitems>menuitems=[
   Menuitems(
    title: 'My Recipes',
     icon:Icons.logout_outlined,
     mnuitmnav: const UserRecipeMain(),
    ),
  Menuitems(
    title: 'My Profile',
     icon:Icons.person_outline,
     mnuitmnav: const MyProfileMain(),
    ),
    Menuitems(
    title: 'Username & Password',
     icon:Icons.lock_outline,
     mnuitmnav: const UserPassMain(),
    ),
     Menuitems(
    title: 'About',
     icon:Icons.info_outline_rounded,
     mnuitmnav: const AboutUsMain(),
    ),
     Menuitems(
    title: 'Sign Out',
     icon:Icons.logout_outlined,
     mnuitmnav: const SignOutButton(),
    ),
   
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.shadecolor,
      body:SafeArea(
        child: Column(
          children: [
            //user photo and details
            const UserProfile(),

            //menu contents
            const SizedBox(height: 30,),
            Expanded(
              child: ListView.builder(
                itemCount: menuitems.length,
                itemBuilder: (context,index){
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        title: Text(menuitems[index].title,
                        style: TextStyle(
                          fontFamily: AppTheme.fonts.jost,
                          fontSize: 20,
                          color: AppTheme.colors.appWhiteColor
                        ),
                        ),
                        leading: Icon(menuitems[index].icon,
                        color: AppTheme.colors.appWhiteColor,
                        size: 30,
                        ),
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>menuitems[index].mnuitmnav)
                          );
                        },
                      ),
                  );
                },
                )
            ),
          ],
        ),
      )
      );
  }
}

class Menuitems{
  final String title;
  final IconData icon;
  final Widget mnuitmnav;

  Menuitems({required this.title,required this.icon,required this.mnuitmnav});
}
