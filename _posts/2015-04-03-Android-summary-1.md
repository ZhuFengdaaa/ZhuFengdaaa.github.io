---
layout: post
title: Android 开发总结-Camera的使用
tag: conference
---
是时候来总结一下多一个月来的安卓开发了。

先来对安卓摄像头做一个复习，这个是手机的重要设备，能玩出很多花样，挺有趣的，也是我们项目的核心。它是重点也是难点，容易出Bug，出了Bug很难调，总之是一折腾人的小妖精。
[onCreate中建立图像捕捉实例](#oncreate)
###Permission 申请权限
* Camera Permission-首先你的应用应该在Manifest.xml申请使用Camera的权限。如果不申请的话在调用camera的时候会有 Exception。
{% highlight xml %}
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera" />
{% endhighlight %}

* Storage Permission-接下来我们还要申请SD卡的读写权限，为了存储我们记录的MP4文件。
{% highlight xml %}
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera" />
{% endhighlight %}

<span id="oncreate"></span>
###打开照相\摄像界面并存储。
如果你仅仅需要打开相机，拍照或者摄像，然后储存在SD卡上，如微信、QQ、足记等等。那么其实只要开启一个intent，并在其中指明存储路径即可。代码如下。(注意：由于存储的时候会读写SD卡，所以你要在Manifest.xml里申请权限，还有真机调试的时候要拔下USB线（因为连着USB线的手机会将SD卡的权限交给电脑），否则就会出现“虚拟机上跑得好好的为啥真机上就跪了呢？” 之类的问题。╮(╯▽╰)╭)
{% highlight java %}
public class MainActivity extends ActionBarActivity {

    Button takeVideo,takePicture;
    private static final int CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE = 100;
    private static final int CAPTURE_VIDEO_ACTIVITY_REQUEST_CODE = 200;

    private Uri fileUri;

    private android.hardware.Camera mCamera;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        takeVideo = (Button)findViewById(R.id.start_button);
        takeVideo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //create new Intent
                Intent intent = new Intent(MediaStore.ACTION_VIDEO_CAPTURE);
//Standard Intent action that can be sent to have the camera application capture a video and return it.
                fileUri = getOutputMediaFileUri(MEDIA_TYPE_VIDEO);  // create a file to save the video
                intent.putExtra(MediaStore.EXTRA_OUTPUT, fileUri);  // set the image file name
                intent.putExtra(MediaStore.EXTRA_VIDEO_QUALITY, 1); // set the video image quality to high

                // start the Video Capture Intent
                startActivityForResult(intent, CAPTURE_VIDEO_ACTIVITY_REQUEST_CODE);
            }
        });

        takePicture = (Button)findViewById(R.id.take_picture);
        takePicture.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // get an image from the camera
                //create new Intent
                Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
//Standard Intent action that can be sent to have the camera application capture a video and return it.
                fileUri = getOutputMediaFileUri(MEDIA_TYPE_IMAGE);  // create a file to save the video
                intent.putExtra(MediaStore.EXTRA_OUTPUT, fileUri);  // set the image file name
                intent.putExtra(MediaStore.EXTRA_VIDEO_QUALITY, 1); // set the video image quality to high

                // start the Video Capture Intent
                startActivityForResult(intent, CAPTURE_VIDEO_ACTIVITY_REQUEST_CODE);
            }
        });
    }

    public static final int MEDIA_TYPE_IMAGE = 1;
    public static final int MEDIA_TYPE_VIDEO = 2;

    /** Create a file Uri for saving an image or video */
    private static Uri getOutputMediaFileUri(int type){
        return Uri.fromFile(getOutputMediaFile(type));
    }

    /** Create a File for saving an image or video */
    private static File getOutputMediaFile(int type){
        // To be safe, you should check that the SDCard is mounted
        // using Environment.getExternalStorageState() before doing this.

        File mediaStorageDir = new File(Environment.getExternalStoragePublicDirectory(
                Environment.DIRECTORY_PICTURES), "MyCameraApp");
        // This location works best if you want the created images to be shared
        // between applications and persist after your app has been uninstalled.

        // Create the storage directory if it does not exist
        if (! mediaStorageDir.exists()){
            if (! mediaStorageDir.mkdirs()){
                Log.d("MyCameraApp", "failed to create directory");
                return null;
            }
        }

        // Create a media file name
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        File mediaFile;
        if (type == MEDIA_TYPE_IMAGE){
            mediaFile = new File(mediaStorageDir.getPath() + File.separator +
                    "IMG_"+ timeStamp + ".jpg");
        } else if(type == MEDIA_TYPE_VIDEO) {
            mediaFile = new File(mediaStorageDir.getPath() + File.separator +
                    "VID_"+ timeStamp + ".mp4");
        } else {
            return null;
        }

        return mediaFile;
    }

    //当相机界面返回的时候用Toast显示存储路径
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE) {
            if (resultCode == RESULT_OK) {
                // Image captured and saved to fileUri specified in the Intent
                Toast.makeText(this, "Image saved to:\n" +
                        data.getData(), Toast.LENGTH_LONG).show();
            } else if (resultCode == RESULT_CANCELED) {
                // User cancelled the image capture
            } else {
                // Image capture failed, advise user
            }
        }

        if (requestCode == CAPTURE_VIDEO_ACTIVITY_REQUEST_CODE) {
            if (resultCode == RESULT_OK) {
                // Video captured and saved to fileUri specified in the Intent
                Toast.makeText(this, "Video saved to:\n" +
                        data.getData(), Toast.LENGTH_LONG).show();
            } else if (resultCode == RESULT_CANCELED) {
                // User cancelled the video capture
            } else {
                // Video capture failed, advise user
            }
        }
    }
}


{% endhighlight %}



[1]:http://developer.android.com/guide/topics/media/camera.html#custom-camera


[2]:http://developer.android.com/reference/android/view/SurfaceView.html




