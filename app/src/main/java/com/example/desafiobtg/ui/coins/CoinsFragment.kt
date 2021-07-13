package com.example.desafiobtg.ui.coins

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ProgressBar
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.DefaultItemAnimator
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.desafiobtg.R
import com.example.desafiobtg.adapters.CoinsAdapter
import com.example.desafiobtg.entity.CoinEntity
import com.example.desafiobtg.models.CoinsDTO
import com.example.desafiobtg.rest.ApiClient
import com.example.desafiobtg.rest.ApiInterface
import com.example.desafiobtg.utils.ConnectionDetector
import com.orm.query.Select
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class CoinsFragment : Fragment() {

    private val LOG_TAG = CoinsFragment::class.java.simpleName

    private var loadListCoins: Call<CoinsDTO>? = null
    private var adapter: CoinsAdapter? = null
    private var coins = ArrayList<CoinEntity>()

    lateinit var rvCoins: RecyclerView
    lateinit var pbCoins: ProgressBar
    lateinit var txtNoCoins: TextView

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_coins, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        setComponents(view)

    }

    private fun setComponents(view: View){
        pbCoins = view.findViewById(R.id.pb_coins)
        txtNoCoins = view.findViewById(R.id.txt_no_coins)

        rvCoins = view.findViewById(R.id.rv_coins)
        rvCoins.layoutManager = LinearLayoutManager(requireContext())
        rvCoins.itemAnimator = DefaultItemAnimator()

        adapter = CoinsAdapter(coins)
        rvCoins.adapter = adapter
    }

    override fun onStart() {
        super.onStart()
        val cd = ConnectionDetector(requireContext())
        if(!cd.isConnectingToInternet){
            loadCoins()
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
                loadCoins()
            }

            override fun onFailure(call: Call<CoinsDTO>?, t: Throwable?) {
                Log.e(LOG_TAG, "error in callApiListCoins: $t")
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
            adapter?.notifyDataSetChanged()
        } else {
            txtNoCoins.visibility = View.VISIBLE
        }

        pbCoins.visibility = View.GONE
    }
}