package fps.daniel.conversormoedas.viewmodel

import android.app.Activity
import android.content.Intent
import android.os.Build
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import android.widget.Toast
import androidx.annotation.RequiresApi
import fps.daniel.conversormoedas.R
import fps.daniel.conversormoedas.data.DataInstance
import fps.daniel.conversormoedas.domain.ConversionLayer
import io.reactivex.disposables.CompositeDisposable
import kotlinx.android.synthetic.main.activity_conversion.*

class ConversionActivity : AppCompatActivity(), ConversionView, MessageView {


    private var conversion : ConversionLayer? = null
    private val compositeDisposable = CompositeDisposable()


    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_conversion)

        //Scene setup and Dependency injection
        conversion = ConversionLayer(this as ConversionView, this as MessageView, DataInstance(), compositeDisposable)
        conversion?.onCreate(this)

        valorOrigem.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(p0: Editable?) {
                conversion?.originalValueChanged(p0?.toString() ?: "")
            }
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}
            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}
        })
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if(resultCode== Activity.RESULT_OK) conversion?.treatActivityResult(requestCode, resultCode, data)
    }

    override fun setOriginalValueText(text: String) {
        valorOrigem.setText(text)
    }

    override fun onOriginalCurrencyButtonClick(view: View) {
        conversion?.selectOriginalCurrency()
    }

    override fun onConvertedCurrencyButtonClick(view: View) {
        conversion?.selectTargetCurrency()
    }

    override fun onConvertButtonClick(view: View) {
        conversion?.convert()
    }

    override fun setOriginalCurrencyButtonText(text: String) {
        originalCurrencyButton.text = text
    }

    override fun setConvertedCurrencyButtonText(text: String) {
        convertedCurrencyButton.text = text
    }

    override fun setConvertedValueText(text : String) {
        convertedValueTextView.text = text
    }

    override fun showCurrencyList(requestCode: Int) {
        startActivityForResult(Intent(this, CurrenciesActivity::class.java), requestCode)
    }

    override fun showToast(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show()
    }

    override fun onDestroy() {
        compositeDisposable.dispose()
        conversion?.onDestroy()
        super.onDestroy()
    }
}