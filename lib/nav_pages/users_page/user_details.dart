import 'package:flutter/material.dart';
import 'package:techtask/nav_pages/users_page/user_model/user_model.dart';

class UserDetails extends StatelessWidget {
  final UserModel user;
  UserDetails({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5777A2),
        title: Text(
          '@${user.username.toString().toLowerCase()}',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 25, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              child: Card(
                color: Colors.grey.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Color(0xFF5777A2),
                            child: Text(
                              user.name![0].toUpperCase(),
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            user.name.toString(),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 1, color: Color(0xFF5777A2)),
                      const SizedBox(height: 10),
                      Text(
                        'Email:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          Icon(Icons.alternate_email, color: Color(0xFF5777A2)),
                          SizedBox(width: 10),
                          Text(
                            user.email.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Address:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          Icon(Icons.location_pin, color: Color(0xFF5777A2)),
                          SizedBox(width: 10),
                          Text(
                            user.address!.street.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          Icon(Icons.home_outlined, color: Color(0xFF5777A2)),
                          SizedBox(width: 10),
                          Text(
                            user.address!.suite.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          Icon(Icons.location_city, color: Color(0xFF5777A2)),
                          SizedBox(width: 10),
                          Text(
                            user.address!.city.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          Icon(Icons.email, color: Color(0xFF5777A2)),
                          SizedBox(width: 10),
                          Text(
                            user.address!.zipcode.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Contacts:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          Icon(Icons.phone, color: Color(0xFF5777A2)),
                          SizedBox(width: 10),
                          Text(
                            user.phone.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          Icon(Icons.web_asset, color: Color(0xFF5777A2)),
                          SizedBox(width: 10),
                          Text(
                            'www.${user.website.toString().toLowerCase()}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Company:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          Icon(Icons.near_me, color: Color(0xFF5777A2)),
                          SizedBox(width: 10),
                          Text(
                            user.company!.name.toString().toLowerCase(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          Icon(Icons.description, color: Color(0xFF5777A2)),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              user.company!.catchPhrase.toString(),
                              style: TextStyle(fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          Icon(Icons.wb_incandescent_rounded,
                              color: Color(0xFF5777A2)),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              user.company!.bs.toString(),
                              style: TextStyle(fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
