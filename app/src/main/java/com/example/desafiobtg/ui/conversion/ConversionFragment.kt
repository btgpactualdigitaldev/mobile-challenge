package com.example.desafiobtg.ui.conversion

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.fragment.app.Fragment
import com.example.desafiobtg.R
import com.example.desafiobtg.entity.CoinEntity
import com.example.desafiobtg.entity.QuoteEntity
import com.example.desafiobtg.models.CoinsDTO
import com.example.desafiobtg.models.QuotationDTO
import com.example.desafiobtg.rest.ApiClient
import com.example.desafiobtg.rest.ApiInterface
import com.example.desafiobtg.utils.ConnectionDetector
import com.orm.query.Condition
import com.orm.query.Select
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response


class ConversionFragment : Fragment(), AdapterView.OnItemSelectedListener {

    private val LOG_TAG = ConversionFragment::class.java.simpleName

    private var coins = ArrayList<CoinEntity>()
    private var loadListCoins: Call<CoinsDTO>? = null
    private var loadQuotations: Call<QuotationDTO>? = null

    private lateinit var pbCoins: ProgressBar
    private lateinit var txtNoCoins: TextView
    private lateinit var txtConversionResult: TextView
    private lateinit var editInputValue: EditText
    private lateinit var layoutConversion: ConstraintLayout
    private lateinit var spinnerOriginValue: Spinner
    private lateinit var spinnerDestinationValue: Spinner

    private lateinit var originAdapter: ArrayAdapter<String>
    private lateinit var destinationAdapter: ArrayAdapter<String>

    private var originValue: Double = 0.0
    private var destinationValue: Double = 0.0
    private var enteredValue: Double? = 0.0

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_conversion, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setComponents(view)
        setListeners()
    }

    private fun setComponents(view: View){
        editInputValue = view.findViewById(R.id.edit_value_origin)

        spinnerOriginValue = view.findViewById(R.id.spinner_origin)
        spinnerDestinationValue = view.findViewById(R.id.spinner_destination)

        pbCoins = view.findViewById(R.id.pb_coins)
        txtNoCoins = view.findViewById(R.id.txt_no_coins)

        txtConversionResult = view.findViewById(R.id.txt_conversion_result)

        layoutConversion = view.findViewById(R.id.layout_conversion)
    }

    private fun setListeners(){
        editInputValue.addTextChangedListener(object : TextWatcher {

            override fun afterTextChanged(s: Editable) {}

            override fun beforeTextChanged(s: CharSequence, start: Int, count: Int, after: Int) {
            }

            override fun onTextChanged(text: CharSequence, start: Int, before: Int, count: Int) {
                enteredValue = text.toString().toDoubleOrNull()
                calculateConversion()
            }
        })
    }

    private fun calculateConversion(){
        enteredValue?.let {
            val dolar = it/originValue
            val result = dolar*destinationValue
            txtConversionResult.text = String.format("%.2f", result)
        } ?: kotlin.run {
            txtConversionResult.text = "0,00"
        }
    }

    override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {

        val coinSelected = coins[position]

        val coinEntity = Select.from(QuoteEntity::class.java)
            .where(Condition.prop("cod").eq("USD${coinSelected.cod}"))
            .first()

        when(parent?.id) {
            R.id.spinner_origin -> {
                originValue = coinEntity.value ?: 0.0
            }
            R.id.spinner_destination -> {
                destinationValue = coinEntity.value ?: 0.0
            }
        }

        calculateConversion()
    }

    override fun onNothingSelected(parent: AdapterView<*>?) {
        TODO("Not yet implemented")
    }

    override fun onStart() {
        super.onStart()
        super.onStart()
        val cd = ConnectionDetector(requireContext())
        if(!cd.isConnectingToInternet){
            loadCoins()
            return
        } else {
            callApiListCoins()
        }
    }

    private fun callApiListCoins() {

        val apiService = ApiClient.getClient().create(ApiInterface::class.java)
        loadListCoins = apiService.getCoinList()

        loadListCoins?.enqueue(object : Callback<CoinsDTO> {
            override fun onResponse(call: Call<CoinsDTO>?, response: Response<CoinsDTO>?) {

                val listCurrencies = response?.body()?.currencies

                response?.body()?.success?.let { success ->
                    if(success && !listCurrencies.isNullOrEmpty()){
                        listCurrencies.forEach { map ->
                            val coin = CoinEntity(map.key, map.value)
                            coin.save()
                        }
                    }
                }
//                loadCoins()
                callApiQuotations()
            }

            override fun onFailure(call: Call<CoinsDTO>?, t: Throwable?) {
                Log.e(LOG_TAG, "error in callApiListCoins: $t")
                callApiQuotations()
            }
        })
    }

    private fun callApiQuotations() {

        val apiService = ApiClient.getClient().create(ApiInterface::class.java)
        loadQuotations = apiService.getQuotation()

        loadQuotations?.enqueue(object : Callback<QuotationDTO> {
            override fun onResponse(call: Call<QuotationDTO>?, response: Response<QuotationDTO>?) {

                val listQuotes = response?.body()?.quotes

                response?.body()?.success?.let { success ->
                    if(success && !listQuotes.isNullOrEmpty()){
                        listQuotes.forEach { map ->
                            val quote = QuoteEntity(map.key, map.value)
                            quote.save()
                        }
                    }
                }
                loadCoins()
            }

            override fun onFailure(call: Call<QuotationDTO>?, t: Throwable?) {
                Log.e(LOG_TAG, "error in callApiQuotations: $t")
                loadCoins()
            }
        })
    }

    private fun loadCoins() {

        val listCoins = Select.from(CoinEntity::class.java)
            .orderBy("cod")
            .list()

        if (!listCoins.isNullOrEmpty()) {

            coins.addAll(listCoins)
            val listNameCoins = listCoins.mapNotNull{element -> element?.name}

            originAdapter = ArrayAdapter(requireContext(), android.R.layout.simple_spinner_item, listNameCoins)
            originAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
            spinnerOriginValue.adapter = originAdapter
            spinnerOriginValue.onItemSelectedListener = this

            destinationAdapter = ArrayAdapter(requireContext(), android.R.layout.simple_spinner_item, listNameCoins)
            destinationAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
            spinnerDestinationValue.adapter = destinationAdapter
            spinnerDestinationValue.onItemSelectedListener = this

            layoutConversion.visibility = View.VISIBLE

        } else {
            txtNoCoins.visibility = View.VISIBLE
            layoutConversion.visibility = View.GONE
        }

        pbCoins.visibility = View.GONE
    }

}