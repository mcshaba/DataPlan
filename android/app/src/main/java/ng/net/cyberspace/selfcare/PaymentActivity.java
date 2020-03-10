package ng.net.cyberspace.selfcare;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.cyberspace.cyberpaysdk.CyberpaySdk;
import com.cyberspace.cyberpaysdk.TransactionCallback;
import com.cyberspace.cyberpaysdk.enums.Mode;
import com.cyberspace.cyberpaysdk.model.Booking;
import com.cyberspace.cyberpaysdk.model.Transaction;

import io.flutter.plugin.common.MethodChannel;

public class PaymentActivity extends AppCompatActivity {
    Transaction transaction;
    MethodChannel methodChannel;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_payment);
//        CyberpaySdk.INSTANCE.initialiseSdk("d5355204f9cf495f853c8f8d26ada19b", Mode.Debug);
        CyberpaySdk.INSTANCE.initialiseSdk("3e1d7d40b9e043b694c7516148f23c3f", Mode.Live);
        CyberpaySdk.INSTANCE.setMerchantLogo(getResources().getDrawable(R.drawable.ic_cyberpay_logo));
        transaction = new Transaction();


        Intent intent = getIntent();
        if(intent.getExtras() != null){

            Bundle b = getIntent().getExtras();
            String reference = b.getString("reference");
            Log.d("REFERENCE", reference);
            transaction.setReference(reference);

        }

        CyberpaySdk.INSTANCE.completeCheckoutTransaction(this, transaction, new TransactionCallback() {
            @Override
            public void onSuccess(Transaction transaction) {
                Log.e("RESPONSE", "SUCCESSFUL");
                Toast.makeText(PaymentActivity.this, "Transaction Successful, Your Data will be Processed ", Toast.LENGTH_SHORT).show();

                Intent returnIntent = getIntent();
                returnIntent.putExtra("result", transaction.getReference());
                setResult(Activity.RESULT_OK, returnIntent);
                finish();
            }

            @Override
            public void onError(Transaction transaction, Throwable throwable) {
                Log.e("ERROR", throwable.getMessage());
                Toast.makeText(PaymentActivity.this, "CyberPay " +throwable.getMessage(), Toast.LENGTH_SHORT).show();
                finish();
            }

            @Override
            public void onValidate(Transaction transaction) {

            }
        });

    }

}
