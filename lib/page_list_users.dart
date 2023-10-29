import 'package:flutter/material.dart';
import 'package:httpreq/api_data_source.dart';
import 'package:httpreq/users_details.dart';
import 'package:httpreq/users_model.dart';

class PageListUsers extends StatelessWidget {
  const PageListUsers({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Users'),
        backgroundColor: Colors.lightBlue,
      ),
      body: _buildListUsersBody(context), // Pass the context
    );
  }

  Widget _buildListUsersBody(BuildContext context) {
    // Add the context parameter
    return Container(
      child: FutureBuilder(
          future: ApiDataSource.instance.loadUsers(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              UsersModel usersModel = UsersModel.fromJson(snapshot.data);
              return _buildSuccessSection(
                  context, usersModel); // Pass the context
            }
            return _buildLoadingSection();
          }),
    );
  }

  Widget _buildErrorSection() {
    return Text('Error');
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(BuildContext context, UsersModel data) {
    // Add the context parameter
    return ListView.builder(
      itemCount: data.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _BuildItemUsers(context, data.data![index]); // Pass the context
      },
    );
  }

  Widget _BuildItemUsers(BuildContext context, Data userData) {
    // Add the context parameter
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetail(userData: userData),
            ));
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Image.network(userData.avatar!),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userData.firstName! + " " + userData.lastName!),
                Text(userData.email!),
              ],
            )
          ],
        ),
      ),
    );
  }
}
