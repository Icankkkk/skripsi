import 'dart:convert';
import 'dart:typed_data';

import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/app_route.dart';
import 'package:discuss_app/config/session.dart';
import 'package:discuss_app/controller/c_account.dart';
import 'package:discuss_app/controller/c_home.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:discuss_app/source/user_source.dart';
import 'package:discuss_app/widget/item_divider.dart';
import 'package:discuss_app/widget/item_stat.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../config/api.dart';
import '../../model/user.dart';

class AccountFragment extends StatelessWidget {
  const AccountFragment({super.key});

  logout(BuildContext context) {
    DInfo.dialogConfirmation(
      context,
      'Logout',
      'Yakin mau keluar?',
    ).then((yes) {
      if (yes ?? false) {
        Session.clearUser().then((success) {
          if (success) {
            context.read<CUser>().data = null;
            context.read<CHome>().indexMenu = 0;
            context.go(AppRoute.login);
          }
        });
      }
    });
  }

  updateImage(BuildContext context) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        String idUser = context.read<CUser>().data!.id;
        String oldImage = context.read<CUser>().data!.image;
        DInfo.dialogConfirmation(context, 'Update', 'yes to confirm')
            .then((yes) async {
          if (yes ?? false) {
            String name = image.name;
            Uint8List bytes = await image.readAsBytes();
            UserSource.updateImage(
              idUser,
              oldImage,
              name,
              base64Encode(bytes),
            ).then((success) {
              if (success) {
                User? newUser = context.read<CUser>().data!..image = name;
                context.read<CUser>().data = newUser;
                Session.setUser(newUser);
                DInfo.snackBarSuccess(context, 'Success Update Image');
              } else {
                DInfo.snackBarSuccess(context, 'Update Image Failed');
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var cUser = context.read<CUser>();
    var cAccount = context.read<CAccount>();
    if (cUser.data == null) return DView.empty();
    cAccount.setStat(cUser.data!.id);
    double widthBoxImage = MediaQuery.of(context).size.width * 0.5;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: widthBoxImage,
              height: widthBoxImage,
              child: Stack(
                children: [
                  Container(
                    width: widthBoxImage,
                    height: widthBoxImage,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 4,
                        color: Theme.of(context).primaryColor,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 6,
                          offset: Offset(2, 3),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(90),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Consumer<CUser>(
                            builder: (contextConsumerUser, _, child) {
                          return Image.network(
                            '${Api.imageUser}/${_.data!.image}',
                            // AppAsset.profileImage,
                            fit: BoxFit.cover,
                            width: widthBoxImage - 20,
                            height: widthBoxImage - 20,
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          DView.spaceHeight(28),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: DView.textTitle(
                  context.watch<CUser>().data!.username,
                  color: Colors.white,
                ),
              ),
              DView.spaceWidth(),
              SizedBox(
                height: 30,
                child: ElevatedButton.icon(
                  onPressed: () => updateImage(context),
                  icon: const Icon(
                    Icons.edit,
                    size: 14,
                  ),
                  label: const Text('Image'),
                ),
              ),
            ],
          ),
          Consumer<CAccount>(
            builder: (contexConsumer, _, child) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Material(
                  elevation: 4,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ItemStat(
                            title: 'Topic',
                            value: _.stat['topic'],
                          ),
                        ),
                        const ItemDivider(),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              //TODO: context.push(AppRoute.follower)
                            },
                            child: ItemStat(
                              title: 'Follower',
                              value: _.stat['follower'],
                            ),
                          ),
                        ),
                        const ItemDivider(),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              //TODO: context.push(AppRoute.following)
                            },
                            child: ItemStat(
                              title: 'Following',
                              value: _.stat['following'],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          DView.spaceHeight(8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                side: BorderSide(
                  width: 1.5,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () => logout(context),
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
