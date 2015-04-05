---
layout: post
title: Android 开发总结-自定义Camera应用
tag: Android
---
这里你可以用自己喜欢的方式调用Camera摄像头，然后去做更多的事情！这里Android开放了一些接口，但也有很多条条框框，必须按照[Android官方的API文档][1]走。否则就会报Exception，一个不小心又是一个难调的Bug。( 虚拟机能正常运行而真机上跪 神马的最讨厌了～ ╮(╯▽╰)╭)

基本流程：

1. **发现和获取摄像头(Detect and Access Camera)**。这里的Detect很重要，你要先看看能不能获取摄像头，可能因为硬件（某手机上没有你要的摄像头，比如手机没有前置摄像头或者摄像头损坏）或者因为摄像头权限的原因无法获取。如果你直接尝试Access，就会有一个Exception，而你又没有及时处理Exception，就会导致程序崩溃。
2. **创建一个预览类(Create a Preview Class)。**创建一个继承[SurfaceView][2]的类按照官方规定，为了用户的隐私和安全考虑，如果开发者想在APP中调用摄像头，必须在屏幕创建一块预览，让用户知道摄像机正在被调用。（之后我们会讨论这个条件如何绕过，当然，是为了实现功能的需要（不是偷窥之类的）。
3. **创建预览布局(Build a Preview Layout)**。同上，创建预览类后通过XML布局将预览类显示出来。
4. **创建一个开启摄像头的的监听按钮(Setup Listeners for Capture)**。在`onCreate`函数里实现按钮监听`Button.setOnClickListener`即可
5. **捕获图像，保存文件 (Capture and Save Files)**这里你需要设置输出格式，路径，等等。
6. **释放摄像头实例(Release the Camera)**

####步骤一-检查摄像头可用性并获取摄像头实例
{% highlight java %}
/** 检查摄像头 Check if this device has a camera */
    private boolean checkCameraHardware(Context context) {
        if (context.getPackageManager().hasSystemFeature(PackageManager.FEATURE_CAMERA)){
            // this device has a camera
            return true;
        } else {
            // no camera on this device
            return false;
        }
    }CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE);
}

/** A safe way to get an instance of the Camera object. */
public static Camera getCameraInstance(){
    Camera c = null;
    try {
        c = Camera.open(); // attempt to get a Camera instance
    }
    catch (Exception e){
        // Camera is not available (in use or does not exist)
    }
    return c; // returns null if camera is unavailable
}
{% endhighlight %}

####步骤二-创建一个预览类

实现了接口`SurfaceHolder.Callback`，所以要重写`surfaceCreated`,`surfaceChanged`,`surfaceDestroyed`。
还有一个注意点，现在的API 21 22 下有两个Camera类型：`android.graphics.camera`(默认Camera)和`android.hardware.camera`。前者偏向3D图片的转换功能，而`android.hardware.camera`更多的是摄像头本身的功能。所以我们声明的时候要写
{% highlight java %}
private android.hardware.Camera mCamera;
{% endhighlight %}

这里是`CameraPreview`类的完整代码

{% highlight java %}
//** A basic Camera preview class */
    public class CameraPreview extends SurfaceView implements SurfaceHolder.Callback {
        private SurfaceHolder mHolder;
        private android.hardware.Camera mCamera;

        public CameraPreview(Context context, android.hardware.Camera camera) {
            super(context);
            mCamera = camera;

            // Install a SurfaceHolder.Callback so we get notified when the
            // underlying surface is created and destroyed.
            mHolder = getHolder();
            mHolder.addCallback(this);
            // deprecated setting, but required on Android versions prior to 3.0
            mHolder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);
        }

        @Override
        public void surfaceCreated(SurfaceHolder holder) {
            // The Surface has been created, now tell the camera where to draw the preview.
            try {
                mCamera.setPreviewDisplay(holder);
                mCamera.startPreview();
            } catch (IOException e) {
                Log.d(TAG, "Error setting camera preview: " + e.getMessage());
            }
        }
        
        @Override
        public void surfaceDestroyed(SurfaceHolder holder) {
            // empty. Take care of releasing the Camera preview in your activity.
        }
        
        @Override
        public void surfaceChanged(SurfaceHolder holder, int format, int w, int h) {
            // If your preview can change or rotate, take care of those events here.
            // Make sure to stop the preview before resizing or reformatting it.

            if (mHolder.getSurface() == null){
                // preview surface does not exist
                return;
            }

            // stop preview before making changes
            try {
                mCamera.stopPreview();
            } catch (Exception e){
                // ignore: tried to stop a non-existent preview
            }

            // set preview size and make any resize, rotate or
            // reformatting changes here

            // start preview with new settings
            try {
                mCamera.setPreviewDisplay(mHolder);
                mCamera.startPreview();

            } catch (Exception e){
                Log.d(TAG, "Error starting camera preview: " + e.getMessage());
            }
        }
    }
{% endhighlight %}

####步骤三-把我们创建的Preview类放在XML layout布局中


***

###附：onCreate()、onStart()、onResume()的使用条件

[Link 1](http://blog.csdn.net/zhao_3546/article/details/12843477)


[2]:http://developer.android.com/reference/android/view/SurfaceView.html
[1]:http://developer.android.com/guide/topics/media/camera.html#custom-camera




