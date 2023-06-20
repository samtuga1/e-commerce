import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../consts/colors.dart';
import '../../providers/theme_provider.dart';

class CartEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/emptycart.png'),
              ),
            ),
          ),
          Text(
            'Your Cart Is Empty',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontSize: 36,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Looks Like You didn\'t \n add anything to your cart yet',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: themeChange.darkTheme
                    ? Theme.of(context).disabledColor
                    : ColorsConsts.subTitle,
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.red),
                ),
                backgroundColor: Colors.redAccent,
              ),
              child: Text(
                'shop now'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
