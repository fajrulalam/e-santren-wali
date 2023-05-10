import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/WidgetTree.dart';
import '../Services/Authentication.dart';

class SideBarListTile extends StatelessWidget {
  final int selectedIndex;
  final int tileIndex;
  final Function onSelected;
  final String title;
  const SideBarListTile(
      {Key? key,
      required this.selectedIndex,
      required this.onSelected,
      required this.tileIndex,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color hoverColor = Colors.white;

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      String imageString = 'images/ic_partners.png';
      switch (title) {
        case 'Apa Kabar Anak':
          imageString = 'images/ic_kabar.png';
          break;
        case 'Berita Asrama':
          imageString = 'images/ic_notification.png';
          break;
        case 'Izin Pulang':
          imageString = 'images/ic_leave.png';
          break;
        case 'Bayar Tagihan':
          imageString = 'images/ic_bayar.png';
          break;
        case 'Donasi untuk Aplikasi':
          imageString = 'images/ic_donasi.png';
          break;
        case 'Logout':
          imageString = 'images/ic_logout.png';
          break;
        default:
          imageString = 'images/ic_partners.png';
      }
      return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: OutlinedButton(
          onHover: (value) {
            setState(() {
              hoverColor =
                  value ? Colors.grey.shade100.withOpacity(0.05) : Colors.white;
            });
          },
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.all(0),
            primary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            backgroundColor: hoverColor,
            side: BorderSide(
              //make the top and bottom right corners rounded

              color: Colors.white,
            ),
          ),
          onPressed: () {
            onSelected(tileIndex);
            Navigator.pop(context);
          },
          child: InkWell(
            mouseCursor: MaterialStateMouseCursor.clickable,
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            // onTap: () {
            //   onSelected(0);
            //   Navigator.pop(context);
            // },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                color: selectedIndex == tileIndex
                    ? Colors.teal.withOpacity(0.2)
                    : Colors.white.withOpacity(0),
              ),
              child: ListTile(
                onTap: () {
                  onSelected(tileIndex);
                  Navigator.pop(context);
                },
                leading: Image(
                  image: AssetImage(imageString),
                  height: 24,
                ),
                trailing: title != 'Berita Asrama'
                    ? null
                    : ClipOval(
                        child: Container(
                          width: 20,
                          height: 20,
                          color: Colors.redAccent,
                          child: Center(
                            child: Text(
                              '1',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                title: Text(
                  title,
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
