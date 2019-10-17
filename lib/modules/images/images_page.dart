import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_app/common/base_widget.dart';
import 'package:responsive_app/common/colors.dart';
import 'package:responsive_app/models/device_screen_type.dart';
import 'package:responsive_app/models/random_image.dart';
import 'package:responsive_app/modules/images/images_bloc.dart';
import 'package:responsive_app/modules/images/images_events.dart';
import 'package:responsive_app/modules/images/images_state.dart';

class ImagesPage extends StatefulWidget {
  @override
  _ImagesPageState createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  String selectedImage;
  @override
  void initState() {
    super.initState();
    selectedImage = '';
  }

  void onImageSelected(String imageUrl) {
    setState(() {
      selectedImage = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
        final bool isDesktop =
            sizingInformation.deviceScreenType == DeviceScreenType.desktop;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Random image'),
            backgroundColor: AppColors.mainColor,
          ),
          drawer: !isDesktop
              ? Drawer(
                  child: _ImagesListTiles(
                    onImageSelected: onImageSelected,
                    isDesktop: isDesktop,
                  ),
                )
              : null,
          body: isDesktop
              ? Row(
                  children: <Widget>[
                    Container(
                      width: 250,
                      child: _ImagesListTiles(
                        onImageSelected: onImageSelected,
                        isDesktop: isDesktop,
                      ),
                    ),
                    Expanded(
                      child: _SelectedImage(selectedImage: selectedImage),
                    ),
                  ],
                )
              : _SelectedImage(selectedImage: selectedImage),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () => BlocProvider.of<ImagesBloc>(context).add(
              FetchImages(),
            ),
            backgroundColor: AppColors.mainColor,
          ),
        );
      },
    );
  }
}

class _SelectedImage extends StatelessWidget {
  const _SelectedImage({
    Key key,
    @required this.selectedImage,
  }) : super(key: key);

  final String selectedImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: selectedImage != ''
          ? Image.network(selectedImage)
          : const Text('No image selected'),
    );
  }
}

class _ImagesListTiles extends StatelessWidget {
  const _ImagesListTiles({
    Key key,
    @required this.onImageSelected,
    @required this.isDesktop,
  }) : super(key: key);
  final Function onImageSelected;
  final bool isDesktop;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagesBloc, ImagesState>(
      builder: (context, state) {
        if (state is ImagesLoaded) {
          final List<RandomImage> images = state.images;
          return ListView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${images[index].author} - ${images[index].id}'),
                onTap: () {
                  onImageSelected(images[index].downloadUrl);
                  if (!isDesktop) {
                    Navigator.of(context).pop();
                  }
                },
              );
            },
          );
        } else if (state is ImagesError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
