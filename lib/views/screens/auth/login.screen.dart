import 'package:fit_worker/utils/icon.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
        appBar: AppBar(
          title: Container(
              alignment: Alignment.center,
              child: const Column(children: [
                Text(
                  "Hey there,",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff0E2D5B),
                  ),
                ),
                Text(
                  "Welcome back",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff0E2D5B),
                  ),
                )
              ])),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 360,
                height: 60,
                child: Material(
                  borderRadius: BorderRadius.circular(100 * fem),
                  color: const Color(0xffF7F8F8),
                  child: const Padding(
                    padding: EdgeInsets.zero,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        hintText: 'Email',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 360,
                height: 60,
                child: Material(
                  borderRadius: BorderRadius.circular(100 * fem),
                  color: const Color(0xffF7F8F8),
                  child: const Padding(
                    padding: EdgeInsets.zero,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                          size: 20,
                        ),
                        // suffixIcon: IconButton(onPressed: onPressed, icon: obc)
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Forgot your password?",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0E2D5B),
                    decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(360 * ffem, 60 * ffem)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff1B2C56)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100 * fem),
                    ))),
                onPressed: () {},
                child: RichText(
                  text: TextSpan(children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: loginIcon,
                      ),
                    ),
                    const TextSpan(
                      text: "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffF7F8F8),
                      ),
                    )
                  ]),
                )),
            const SizedBox(height: 20),
            const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: Color(0xffDDDADA),
                      thickness: 1.5,
                      indent: 2,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Or",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff0E2D5B),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Divider(
                      color: Color(0xffDDDADA),
                      thickness: 1.5,
                      endIndent: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: facebookIcon,
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {},
                    icon: facebookIcon,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(
                      // Style mặc định cho TextSpan
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff0E2D5B),
                    ),
                    children: [
                      TextSpan(text: "Don't have an account yet? "),
                      TextSpan(
                          text: "Register",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ]),
              ),
            ),
            const SizedBox(height: 20),
          ],
        )));
  }
}
