import 'package:flutter/material.dart';

class DaftarTagihanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tagihan'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Pecel lele"),
            subtitle: Text("Pesanan yang harus dibayar"),
            trailing: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 0, 0, 0)),
              ),
              onPressed: () {},
              child: Text('Rp.12000'),
            ),
            isThreeLine: true,
            onTap: () {
              print("On Tap is fired");
            },
          ),
          ListTile(
            title: Text("Laundry"),
            subtitle: Text("Pesanan yang harus dibayar"),
            trailing: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 0, 0, 0)),
              ),
              onPressed: () {},
              child: Text('Rp.30000'),
            ),
            isThreeLine: true,
            onTap: () {
              print("On Tap is fired");
            },
          ),
          ListTile(
            title: Text("Nasi Kuning"),
            subtitle: Text("Pesanan yang harus dibayar"),
            trailing: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 0, 0, 0)),
              ),
              onPressed: () {},
              child: Text('Rp.12000'),
            ),
            isThreeLine: true,
            onTap: () {
              print("On Tap is fired");
            },
          ),
        ],
      ),
    );
  }
}
