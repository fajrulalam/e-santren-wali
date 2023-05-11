import 'package:esantrenwali_v1/Objects/AnakSantriObject.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SidebarListTile.dart';

class Sidebar extends StatelessWidget {
  final AnakSantriObject anakSantriObject;
  final int selectedIndex;
  final Function onSelected;

  const Sidebar({
    required this.selectedIndex,
    required Function this.onSelected,
    Key? key,
    required this.anakSantriObject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return //build a statefulbuilder
        StatefulBuilder(builder: (context, StateSetter setState) {
      return Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //add sidebar header
          InkWell(
            onTap: () {},
            child: Container(
              // color: Colors.teal.withOpacity(0.1),
              // padding: EdgeInsets.all(16),
              height: 200,
              child: DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //cicular avatar from image network
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                        anakSantriObject.pathFotoProfil!,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              anakSantriObject.nama!,
                              style: GoogleFonts.balooThambi2(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              anakSantriObject.id!,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.balooThambi2(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SideBarListTile(
              tileIndex: 0,
              title: 'Apa Kabar Anak',
              selectedIndex: selectedIndex,
              onSelected: onSelected),
          SideBarListTile(
              tileIndex: 1,
              title: 'Berita Asrama',
              selectedIndex: selectedIndex,
              onSelected: onSelected),
          SideBarListTile(
              tileIndex: 2,
              title: 'Izin Pulang',
              selectedIndex: selectedIndex,
              onSelected: onSelected),
          SideBarListTile(
              tileIndex: 3,
              title: 'Bayar Tagihan',
              selectedIndex: selectedIndex,
              onSelected: onSelected),
          SideBarListTile(
              tileIndex: 4,
              title: 'Donasi untuk Aplikasi',
              selectedIndex: selectedIndex,
              onSelected: onSelected),
          SideBarListTile(
              tileIndex: 5,
              title: 'Logout',
              selectedIndex: selectedIndex,
              onSelected: onSelected),
        ],
      ));
    });
  }
}
