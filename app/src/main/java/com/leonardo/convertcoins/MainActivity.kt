package com.leonardo.convertcoins

import android.content.Context
import android.content.Intent
import android.content.res.Configuration
import android.os.Bundle
import android.text.*
import android.text.style.AlignmentSpan

import android.view.MotionEvent
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.leonardo.convertcoins.config.Keys
import com.leonardo.convertcoins.config.RetrofitConfig
import com.leonardo.convertcoins.config.scrollToBottom
import com.leonardo.convertcoins.databinding.ActivityMainBinding
import com.leonardo.convertcoins.models.Rate
import com.leonardo.convertcoins.models.RealtimeRates
import com.leonardo.convertcoins.models.SupportedCurrencies
import com.leonardo.convertcoins.services.ConvertService
import com.leonardo.convertcoins.services.SQLiteService

import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.math.BigDecimal
import java.util.*

class MainActivity : AppCompatActivity() {
    object INDEX {
        const val HAVE = 0 // INDEX of selected list
        const val WANT = 1 // INDEX of selected list
    }

    object ERROR {
        const val SUPPORTED_CURRENCIES = "SUPPORTED_CURRENCIES"
        const val REALTIME_RATES = "REALTIME_RATES"
        const val LOAD_COIN = "LOAD_COIN"
    }

    object DEFAULT {
        object LABEL {
            const val HAVE = "BRL"
            const val WANT = "USD"
        }
    }

    private var toConvertValue = BigDecimal.ZERO

    private val apiConfig = RetrofitConfig()
    private val convertService = ConvertService()
    private val apiKey = Keys().apiKey()


    // map related to the button clicked so when user returns from CurrencyList
    // we can know which information needs to be updated
    private val layoutIdMap = mapOf(
        R.id.layout_I_have to mapOf(
            "selected" to INDEX.HAVE
        ),
        R.id.layout_I_want to mapOf(
            "selected" to INDEX.WANT
        )
    )

    // start selected list values (currency I have being the first index and currency I want being the second)
    // with negative rates because we do not called the API yet
    private val selected = mutableListOf(Rate(0.0, ""), Rate(0.0, ""))
    private lateinit var dbService: SQLiteService
    private lateinit var realtimeRates: RealtimeRates
    private lateinit var supportedCurrencies: SupportedCurrencies
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // setting up property binding library
        binding = ActivityMainBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)
        startLoading()

        // set tags to differentiate layouts when returning from currencyList.
        // this is the value that will be used on layoutId map to know which
        // currency should be updated (currency I want or currency I have)
        binding.layoutIHave.buttonChangeCurrency.setTag(R.id.TAG_LAYOUT_ID, R.id.layout_I_have)
        binding.layoutIWant.buttonChangeCurrency.setTag(R.id.TAG_LAYOUT_ID, R.id.layout_I_want)

        dbService = SQLiteService(applicationContext, MODE_PRIVATE)
        supportedCurrencies = dbService.getSavedSupportedCurrencies()
        realtimeRates = dbService.getSavedRealtimeRates()

        initViewItems()
        initCoins()
        initCurrencyLayer()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        val currencyRequestCode = resources.getInteger(R.integer.REQUEST_CURRENCY_LIST)
        if (resultCode == RESULT_OK && requestCode == currencyRequestCode) {
            if (data !== null) {
                val layoutId = data.getIntExtra("ID", 0)
                val coin = data.getStringExtra("CURRENCIES")
                if (layoutId != 0 && coin !== null) {
                    setCoin(layoutId, coin)
                    convertCurrency(toConvertValue.toString())  // call again when currency changes
                }
                else
                    errorHandler("Erro ao carregar a moeda", ERROR.LOAD_COIN)
            }
        }
    }

    /**
     * Init currencyLayer api calling both realtimeRates and supportedCurrencies
     */
    private fun initCurrencyLayer() {
        callRealtimeRates()
        callSupportedCurrencies()
    }

    /**
     * Init view elements and set needed listeners
     */
    private fun initViewItems() {
        // init currencies labels
        binding.layoutIHave.currencyLabel.text = DEFAULT.LABEL.HAVE
        binding.layoutIWant.currencyLabel.text = DEFAULT.LABEL.WANT

        with(binding.inputToConvert) {
            // changes input keyboard
            setRawInputType(Configuration.KEYBOARD_12KEY);
            // add listener so every time user types a new value its automatic converted
            addTextChangedListener(object : TextWatcher {
                override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

                override fun onTextChanged(s: CharSequence, start: Int, before: Int, count: Int) {
                    removeTextChangedListener(this)
                    // change the first comma to dot so it can be properly parsed
                    // as a bigDecimal value and clean all remain commas inserted.
                    // We don't need to care about another dots because the dot period
                    // button is disabled
                    val value = s
                        .toString()
                        .replaceFirst(",", ".")
                        .replace(",", "")
                    convertCurrency(value)
                    addTextChangedListener(this)
                }

                override fun afterTextChanged(s: Editable?) {}
            })
        }

        binding.inputToConvert.setOnTouchListener { v, event ->
            when (event?.action) {
                MotionEvent.ACTION_DOWN -> {
                    with(binding.mainScrollView) {
                        postDelayed({
                            scrollToBottom() // extension
                        }, 450)
                    }
                }

                MotionEvent.ACTION_UP -> {
                    v?.performClick()
                }
            }
            v?.onTouchEvent(event) ?: true
        }
    }

    private fun startLoading() {
        binding.loadingPanel.visibility = View.VISIBLE
        binding.mainLayout.visibility = View.GONE
    }

    private fun finishLoading() {
        binding.loadingPanel.visibility = View.GONE
        binding.mainLayout.visibility = View.VISIBLE
    }


    /** Navigate to CurrencyList Activity to select a currency
     * @param view is the button clicked (either to change currency I have or currency I want)
     */
    fun goToCurrencyList(view: View) {
        intent = Intent(applicationContext, CurrencyList::class.java)
        intent.putExtra("ID", view.getTag(R.id.TAG_LAYOUT_ID).toString().toInt())
        intent.putExtra("CURRENCIES", supportedCurrencies.currencies)
        val requestCode = resources.getInteger(R.integer.REQUEST_CURRENCY_LIST)
        startActivityForResult(intent, requestCode)
    }

    /**
     * Invert coin I have with coin I want and call convertCurrency again to update and show
     * the converted value properly.
     */
    fun invertCoins(@Suppress("UNUSED_PARAMETER")view: View) {
        selected.reverse()
        setCoin(R.id.layout_I_have, selected[INDEX.HAVE].coin)
        setCoin(R.id.layout_I_want, selected[INDEX.WANT].coin)
        convertCurrency(toConvertValue.toString())
    }

    /** Update all activity variables related to the selected coin
     * @param layoutId to differ "I have" and "I want" layouts, and then, update the right variables
     * @param coin as "AUD"
     */
    private fun setCoin(layoutId: Int, coin: String) {
        setCoinOnTemplate(layoutId, coin)
        setCoinOnSharedPreferences(layoutId, coin)
    }

    /** Set coin on template updating image, label and state list "selected"
     * @param layoutId to differ "I have" and "I want" layouts, and then, update the right variables
     * @param coin as "AUD"
     */
    private fun setCoinOnTemplate(layoutId: Int, coin: String) {
        val templateIds = layoutIdMap[layoutId]
        if (templateIds != null) {
            // access buttonMap properties to get selected index and
            // view ids (text and image) to properly update the template
            val index = templateIds["selected"]!!

            val layout: View = findViewById(layoutId)
            val label = layout.findViewById<TextView>(R.id.currency_label)
            val image = layout.findViewById<ImageView>(R.id.currency_image)

            val rate = convertService.getCurrentRate(coin, realtimeRates.quotes)
            selected[index] = Rate(rate, coin)

            // draw the res image related to the selected currency if it exists,
            // otherwise, draw default coin label
            val id = resources.getIdentifier("@drawable/${coin.toLowerCase()}", null, packageName)
            if (id > 0) image.setImageResource(id)
            else image.setImageResource(R.drawable.coin_icon)
            // update label
            label.text = coin
        }
    }

    /** Set coin on shared preferences saving only the string representing the selected coin
     * @param layoutId to differ "I have" and "I want" layouts, and then, update the right variables
     * @param coin as "AUD"
     */
    private fun setCoinOnSharedPreferences(layoutId: Int, coin: String) {
        val sharedPref = getPreferences(Context.MODE_PRIVATE)
        with (sharedPref.edit()) {
            putString(layoutId.toString(), coin)
            apply()
        }
    }

    /**
     * Function that wrapper both coins to be initialized and should be called
     * every time realtimeRate variable is updated
     */
    private fun initCoins() {
        initCoin(R.id.layout_I_have, DEFAULT.LABEL.HAVE)
        initCoin(R.id.layout_I_want, DEFAULT.LABEL.WANT)
    }
    /** Access shared preferences to get last user selected coin. Used to start the screen
     * When the user do not selected any coin yet
     * @param layoutId to differ "I have" and "I want" layouts, and then, update the right variables
     * @param defaultCoin as "AUD". Will be used only if another coin is not found
     */
    private fun initCoin(layoutId: Int, defaultCoin: String) {
        val sharedPref = getPreferences(Context.MODE_PRIVATE)
        val coin = sharedPref.getString(layoutId.toString(), defaultCoin)!!
        setCoin(layoutId, coin)
    }

    /**
     * Call convertService, calculate the converted value and show it to the user
     * @param toConvertValue is the value input from user to be converted between currencies
     */
    private fun convertCurrency(toConvertValue: String?) {
        this.toConvertValue = if( toConvertValue.isNullOrBlank()) BigDecimal.ZERO else toConvertValue.toBigDecimal()
        val convertedValue = convertService.convert(selected[INDEX.HAVE], selected[INDEX.WANT], this.toConvertValue)
        binding.finalValue.text = convertService.getFormattedValue(convertedValue)
    }

    /**
     * Call supported currencies api and return all supported conversion currencies
     */
    private fun callSupportedCurrencies() {
        val currenciesCall = apiConfig.currencyService().getSupportedCurrencies((apiKey))
        currenciesCall.enqueue(object : Callback<SupportedCurrencies> {
            var errorLabel = "Erro ao fazer a requisição de moedas disponíveis."
            override fun onResponse(call: Call<SupportedCurrencies>, response: Response<SupportedCurrencies>) {
                if (response.body() != null && response.body()!!.success && response.body()?.currencies != null) {
                    supportedCurrencies = response.body() as SupportedCurrencies
                    dbService.saveCurrencies(supportedCurrencies)
                } else {
                    if (response.body()?.error !== null) errorLabel = response.body()?.error!!.info
                    errorHandler(errorLabel, ERROR.SUPPORTED_CURRENCIES)
                }
            }

            override fun onFailure(call: Call<SupportedCurrencies>, t: Throwable) {
                errorHandler(errorLabel, ERROR.SUPPORTED_CURRENCIES)
            }
        })
    }

    /**
     * Call realtime rates api and return rates related to the USD coin
     */
    private fun callRealtimeRates() {
        val ratesCall = apiConfig.currencyService().getRealtimeRates(apiKey)

        ratesCall.enqueue(object: Callback<RealtimeRates> {
            var errorLabel = "Erro ao fazer a requisição de taxas"
            override fun onResponse(call: Call<RealtimeRates>, response: Response<RealtimeRates>) {
                if (response.body() != null && response.body()!!.success && response.body()?.quotes != null) {
                    realtimeRates = response.body() as RealtimeRates
                    dbService.saveQuotes(realtimeRates)
                    initCoins()
                } else {

                    if (response.body()?.error !== null)
                        errorLabel = response.body()?.error!!.info
                    errorHandler(errorLabel, ERROR.REALTIME_RATES)
                }

                finishLoading()
            }

            override fun onFailure(call: Call<RealtimeRates>, t: Throwable) {
                errorHandler(errorLabel, ERROR.REALTIME_RATES)
                finishLoading()
            }
        })

    }

    /** Handle api errors
     * @param label what should be printed on the toast
     * @param type that should be one of the object ERROR types
     */
    private fun errorHandler(label: String, type: String) {
        checkShowToast(label, type)
        checkDisableButtons(type)
        checkShowDialog(type)
    }

    /**
     * Check if toast should be shown for the specific error type
     * @param label what should be printed on the toast
     * @param type that should be one of the object ERROR types
     */
    private fun checkShowToast(label: String, type: String) {
        if (type != ERROR.REALTIME_RATES) {
            showToast(label)
        }
    }
    /**
     * Show error toast on screen with a spannable String centralized
     * @param label text to be centrilzed and displayed inside the toast
     */
    private fun showToast(label: String) {
        val text = SpannableString(label)
        text.setSpan(AlignmentSpan.Standard(Layout.Alignment.ALIGN_CENTER),
                0, text.length - 1, Spannable.SPAN_INCLUSIVE_EXCLUSIVE
        )
        Toast.makeText(this@MainActivity, text, Toast.LENGTH_SHORT).show()
    }

    /**
     * Check if buttons should be mark as disable blocking naviagete to currencyList
     * @param type that should be one of the object  ERROR types
     */
    private fun checkDisableButtons(type: String) {
        if (type == ERROR.SUPPORTED_CURRENCIES
                && (!this::supportedCurrencies.isInitialized || supportedCurrencies.currencies.isEmpty())) {
            binding.layoutIHave.buttonChangeCurrency.isEnabled = false
            binding.layoutIWant.buttonChangeCurrency.isEnabled = false
        }
    }

    /**
     * Check if dialog should be shown based on error type
     * @param type that should be one of the object ERROR types
     */
    private fun checkShowDialog(type: String) {
        if (type === ERROR.REALTIME_RATES
                && (!this::realtimeRates.isInitialized || realtimeRates.quotes.isEmpty())) {
            val dialog = AlertDialog.Builder(this@MainActivity)
            dialog.setTitle("Erro ao carregar as cotações")
            dialog.setMessage("Não foi possível carregar as informações referentes as cotações" +
                    " das moedas. Verifique sua interenet e tente novamente")
            dialog.setPositiveButton("OK", null)
            dialog.create()
            dialog.show()
        }
    }
}