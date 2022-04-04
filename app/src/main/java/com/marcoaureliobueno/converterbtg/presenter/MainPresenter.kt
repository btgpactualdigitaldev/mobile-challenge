package com.marcoaureliobueno.converterbtg.presenter

import com.marcoaureliobueno.converterbtg.model.Currency
import com.marcoaureliobueno.converterbtg.model.ListCurrenciesResponse
import com.marcoaureliobueno.converterbtg.model.ResultadoConversao
import com.marcoaureliobueno.converterbtg.mvp.MainMVP
import kotlinx.coroutines.*
import okhttp3.OkHttpClient
import okhttp3.Request
import org.json.JSONException
import org.json.JSONObject
import java.lang.ref.WeakReference
import java.util.*
import kotlin.collections.ArrayList
import kotlin.coroutines.CoroutineContext
import java.math.BigDecimal
import java.math.RoundingMode
/*

https://api.currencylayer.com/convert?from=EUR&to=GBP&amount=100


http://api.currencylayer.com/live?access_key=b8ce2a92d3cc466f576c7a439ba80d97


 */



class MainPresenter (
    view : MainMVP.View
) : MainMVP.Presenter, CoroutineScope {
    override val coroutineContext: CoroutineContext = Dispatchers.Main

    private val view: WeakReference<MainMVP.View> = WeakReference(view)

    val url : String = "http://api.currencylayer.com/list?access_key=b8ce2a92d3cc466f576c7a439ba80d97"
    val key : String = "b8ce2a92d3cc466f576c7a439ba80d97"
    var urlconversao : String = "http://api.currencylayer.com/live?"

    private var listacurrencies = ArrayList<Currency>()


    override fun checkInternet() {
        TODO("Not yet implemented")
    }
    public override fun setLit(list: ArrayList<Currency>){
        this.listacurrencies = list
    }

    public override fun listCurrencies(): Deferred<ListCurrenciesResponse>  = GlobalScope.async {

        val lista = ArrayList<Currency>()

        var resposta : ListCurrenciesResponse

        val request = Request.Builder()
            .url(url)
            .get()
            .build()

        try {
            val response = OkHttpClient().newCall(request).execute()
            val resp = response.body()?.string()
            response.close()

            if (resp.isNullOrEmpty() || resp == "null")
                //return lista
                ListCurrenciesResponse(lista)

            val tudo = JSONObject(resp)

            val itens = tudo.getJSONObject("currencies")
            //val especialidades = ArrayList<Especialidade>()

            val iter: Iterator<String> = itens.keys()
            while (iter.hasNext()) {
                val key = iter.next()
                try {
                    val value: Any = itens.get(key)

                    val curr = Currency().apply {
                        code = key
                        if (value is String)
                        name = value
                    }
                    println("key = " + curr.code + " value = " + curr.name)
                    lista.add(curr)
                } catch (e: JSONException) {
                    // Something went wrong!
                }
            }

            println( itens.javaClass.name)

            //return resposta
            listacurrencies = lista
            ListCurrenciesResponse(lista)
        } catch (e: Exception) {
            e.printStackTrace()
            //return resposta
            ListCurrenciesResponse(lista)
        }
    }

    public override fun getListaCurrencies() : ArrayList<Currency>{
        return listacurrencies
    }

    override fun enviaParaConverter(currdeenvia : String, currparaenvia : String, valorenvia : String): Deferred<ResultadoConversao>  = GlobalScope.async {

        //var urlfinal : String = urlconversao + "access_key=b8ce2a92d3cc466f576c7a439ba80d97" + "&from=" + currdeenvia + "&to=" + currparaenvia + "&amount=" + valorenvia
        var urlfinal : String = urlconversao + "access_key=b8ce2a92d3cc466f576c7a439ba80d97" + "&currencies=" + currdeenvia+","+currparaenvia
        println("urlfinal : "+urlfinal)
        val request = Request.Builder()
            .url(urlfinal)
            .get()
            .build()

        try {
            val response = OkHttpClient().newCall(request).execute()
            val resp = response.body()?.string()
            response.close()

            //if (resp.isNullOrEmpty() || resp == "null")
            //return lista
            //    ResultadoConversao(lista)

            val tudo = JSONObject(resp)
            println(tudo)

            val quotes = tudo.getJSONObject("quotes")
            val pcstr = "USD"+currdeenvia
            val pci = quotes.getDouble(pcstr)

            val scstr = "USD"+currparaenvia
            val sci = quotes.getDouble(scstr)
            println(pcstr + pci +  "    /    " + scstr + sci)


            val valordou = valorenvia.toDouble()
            val res1 = valordou/pci
            val res2 = res1 * sci

            view.get()?.retornaValorResultado(res2)
            /*val itens = tudo.getJSONObject("currencies")
            //val especialidades = ArrayList<Especialidade>()

            val iter: Iterator<String> = itens.keys()
            while (iter.hasNext()) {
                val key = iter.next()
                try {
                    val value: Any = itens.get(key)

                    val curr = Currency().apply {
                        code = key
                        if (value is String)
                            name = value
                    }
                    println("key = " + curr.code + " value = " + curr.name)
                    lista.add(curr)
                } catch (e: JSONException) {
                    // Something went wrong!
                }
            }*/


            ResultadoConversao("semresultado")
        } catch (e: Exception) {
            e.printStackTrace()
            //return resposta
            ResultadoConversao("semresultado")
        }
    }
    fun Double.round(decimals: Int = 2): Double = "%.${decimals}f".format(this).toDouble()
}