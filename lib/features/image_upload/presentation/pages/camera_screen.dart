import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visionsnap/core/theme/glass_theme.dart';
import 'package:visionsnap/features/image_upload/presentation/bloc/upload_bloc.dart';
import 'package:visionsnap/features/image_upload/presentation/bloc/upload_event.dart';
import 'package:visionsnap/features/image_upload/presentation/bloc/upload_state.dart';
import 'package:visionsnap/main.dart';

import '../widgets/camera_header.dart';
import '../widgets/camera_overlay.dart';
import '../widgets/camera_controls.dart';
import '../widgets/image_preview_view.dart';

class CameraScreen extends StatefulWidget {
  final bool openGalleryInitially;
  const CameraScreen({super.key, this.openGalleryInitially = false});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  File? _selectedImage;
  bool _isCameraInitialized = false;
  final ImagePicker _picker = ImagePicker();
  FlashMode _currentFlashMode = FlashMode.off;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.openGalleryInitially) {
      _pickImage(ImageSource.gallery);
    } else {
      _initializeCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller!.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();
    if (status.isPermanentlyDenied) {
      openAppSettings();
      return;
    }

    if (cameras.isEmpty) return;

    _controller = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      await _controller!.setFlashMode(_currentFlashMode);
      if (!mounted) return;
      setState(() {
        _isCameraInitialized = true;
        _selectedImage = null;
      });
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
          _isCameraInitialized = false;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    if (_controller!.value.isTakingPicture) return;

    try {
      final XFile picture = await _controller!.takePicture();
      setState(() {
        _selectedImage = File(picture.path);
        _isCameraInitialized = false;
      });
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  Future<void> _toggleFlash() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    final newMode = _currentFlashMode == FlashMode.off
        ? FlashMode.torch
        : FlashMode.off;
    await _controller!.setFlashMode(newMode);
    setState(() => _currentFlashMode = newMode);
  }

  void _uploadImage() {
    if (_selectedImage != null) {
      context.read<UploadBloc>().add(
        UploadImageEvent(imageFile: _selectedImage!, source: 'mobile_app'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<UploadBloc, UploadState>(
        listener: (context, state) {
          if (state is UploadSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Image uploaded successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is UploadError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Upload Failed: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (_selectedImage != null) {
            return ImagePreviewView(
              imageFile: _selectedImage!,
              onUpload: _uploadImage,
              onRetake: _initializeCamera,
              isLoading: state is UploadLoading,
            );
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              if (_isCameraInitialized && _controller != null)
                OverflowBox(
                  maxWidth: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 1 / _controller!.value.aspectRatio,
                    child: CameraPreview(_controller!),
                  ),
                )
              else
                GlassTheme.meshBackground(),

              if (_isCameraInitialized) const CameraOverlay(),

              SafeArea(
                child: Column(
                  children: [
                    CameraHeader(onClose: () => Navigator.pop(context)),
                    const Spacer(),
                    CameraControls(
                      onGalleryTap: () => _pickImage(ImageSource.gallery),
                      onCaptureTap: _takePicture,
                      onFlashTap: _toggleFlash,
                      isFlashActive: _currentFlashMode == FlashMode.torch,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
