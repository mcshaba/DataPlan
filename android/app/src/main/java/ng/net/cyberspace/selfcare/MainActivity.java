package ng.net.cyberspace.selfcare;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.cyberspace.cyberpaysdk.model.Booking;
import com.cyberspace.cyberpaysdk.model.Split;

import java.util.List;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private String CHANNEL = "com.startActivity/testChannel";
    MethodChannel methodChannel;

    int RESULT_CODE = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);


        methodChannel = new MethodChannel(getFlutterView(), CHANNEL);
        methodChannel.setMethodCallHandler((call, result) -> {
            switch (call.method) {
                case "chargeCard":

                    String reference = call.argument("reference");
//                    final Map arguments = call.arguments();
//                    booking.setTransRef((String) arguments.get("transRef"));
//                    booking.setAmount((Double) arguments.get("amount"));
//                    booking.setEmail((String) arguments.get("email"));
//                    booking.setFullName((String) arguments.get("fullName"));
//                    booking.setPhoneNumber((String) arguments.get("phoneNumber"));


                    Intent intent = new Intent(MainActivity.this, PaymentActivity.class);
                    intent.putExtra("reference", reference);
                    startActivityForResult(intent, RESULT_CODE);
                    //result.success("SUCCESS");

                default:
                    result.notImplemented();
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == RESULT_CODE) {
            if (resultCode == Activity.RESULT_OK) {
                String result = data.getStringExtra("result");
                methodChannel.invokeMethod("onSuccess", result);
            }
        }
        super.onActivityResult(requestCode, resultCode, data);
    }
}
