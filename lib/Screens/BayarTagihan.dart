import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BayarTagihan extends StatefulWidget {
  const BayarTagihan({Key? key}) : super(key: key);

  @override
  State<BayarTagihan> createState() => _BayarTagihanState();
}

class _BayarTagihanState extends State<BayarTagihan> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('images/in-progress.png',
              width: MediaQuery.of(context).size.width * 0.9),
          const SizedBox(height: 20),
          Center(
            child: Text('Fitur ini sedang dalam pengembangan',
                textAlign: TextAlign.center,
                style: GoogleFonts.inconsolata(
                    fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
