package br.com.conversordemoedas.view.activty

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.AdapterView
import androidx.recyclerview.widget.LinearLayoutManager
import br.com.conversordemoedas.R
import br.com.conversordemoedas.model.Currency
import br.com.conversordemoedas.model.List
import br.com.conversordemoedas.view.adapter.CurrencyAdapter
import br.com.conversordemoedas.view.adapter.RecyclerItemClickListener
import br.com.conversordemoedas.viewmodel.CurrencyViewModel
import kotlinx.android.synthetic.main.activity_currency.*
import org.koin.android.viewmodel.ext.android.viewModel
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class CurrencyActivity : AppCompatActivity() {

    var listCurrency = listOf<Currency>()

    private val currencyViewModel: CurrencyViewModel by viewModel()

    private val currencyAdapter: CurrencyAdapter by lazy{ CurrencyAdapter() }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currency)

        recycler_view.adapter = currencyAdapter
        recycler_view.layoutManager = LinearLayoutManager(this)
        getCurrencyList()

        recycler_view.addOnItemTouchListener(
            RecyclerItemClickListener(this, recycler_view,
                object: RecyclerItemClickListener.OnItemClickListener{
                    override fun onItemClick(view: View?, position: Int) {
                        onItemSelected(listCurrency[position])
                    }

                    override fun onItemClick(p0: AdapterView<*>?, p1: View?, p2: Int, p3: Long) {}

                    override fun onLongItemClick(view: View?, position: Int) {}

                }
            )
        )

    }

    private fun getCurrencyList() {
        currencyViewModel.getCurrencyList(object: Callback<List>{
            override fun onFailure(call: Call<List>, t: Throwable) {}

            override fun onResponse(call: Call<List>, response: Response<List>) {
                val list: List? = response.body()
                if (list != null) {
                    listCurrency = currencyViewModel.createCurrencyList(list)
                    currencyAdapter.add(listCurrency)
                }
            }

        })
    }

    fun onItemSelected(item: Currency){
        val intent = Intent()
        intent.putExtra("currency", item)
        setResult(Activity.RESULT_OK, intent)
        finish()
    }

}
