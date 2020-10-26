package com.marcoaureliobueno.converterbtg.view

import android.content.Intent
import android.content.SharedPreferences
import android.os.Bundle
import android.widget.AdapterView
import android.widget.Button
import android.widget.ListView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.marcoaureliobueno.converterbtg.R
import com.marcoaureliobueno.converterbtg.adapter.MyListAdapter
import com.marcoaureliobueno.converterbtg.model.Currency
import com.marcoaureliobueno.converterbtg.mvp.ListCurrenciesMVP
import com.marcoaureliobueno.converterbtg.presenter.ListCurrenciesPresenter
import kotlinx.android.synthetic.main.listcurrenciesactivity.*

class ListCurrenciesActivity  : AppCompatActivity(), ListCurrenciesMVP.View{

    private val presenter: ListCurrenciesMVP.Presenter by lazy {
        ListCurrenciesPresenter(
            this
        )
    }
    var listView: ListView? = null
    var operacao : String? = ""
    var prefs: SharedPreferences? = null
    var myListAdapter : MyListAdapter? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.listcurrenciesactivity)
        val PREFS_FILENAME = "com.marcoaureliobueno.converterbtg.prefs"

        prefs = this.getSharedPreferences(PREFS_FILENAME, 0)
        btnordalfax.setOnClickListener { reordenarAlfabeticoView() }
        btnordcod.setOnClickListener { reordenaPeloCodigo() }
        presenter.listacurrencies = intent.getSerializableExtra("listacurr") as ArrayList<Currency>
        var operacao2 = intent.getStringExtra("operacao") as String
        operacao = operacao2

        println(presenter.listacurrencies)
        listView = findViewById(R.id.listcurrenciesx) as ListView


        //val language = arrayOf<String>("C","C++","Java",".Net","Kotlin","Ruby","Rails","Python","Java Script","Php","Ajax","Perl","Hadoop")

        var arraylst = Array(0, {"string"})
        for (curr in presenter.listacurrencies){
            arraylst = append(arraylst,curr.code)
        }

        println("tamanho aux array = " + arraylst.size + "   tamanho do array curr = " + presenter.listacurrencies.size)
        myListAdapter = MyListAdapter(this,arraylst,presenter.listacurrencies)
        this.listView!!.adapter = myListAdapter
        //myListAdapter.notifyDataSetChanged()

        this.listView!!.onItemClickListener = AdapterView.OnItemClickListener { adapterView, view, position, id ->
            val itemAtPos = adapterView.getItemAtPosition(position) as String
            val itemIdAtPos = adapterView.getItemIdAtPosition(position) as Long
            //Toast.makeText(this, "Item escolhido $itemAtPos  com id $itemIdAtPos", Toast.LENGTH_LONG).show()
            val PREFS_FILENAME = "com.marcoaureliobueno.converterbtg.prefs"
            val prefs: SharedPreferences = this.getSharedPreferences(PREFS_FILENAME, 0);
            if(operacao.equals("de")) {
                prefs.edit().putString("currde", itemAtPos).apply()
            }else{
                prefs.edit().putString("currpara", itemAtPos).apply()
            }
            val i = Intent(this@ListCurrenciesActivity, MainActivity::class.java)
            startActivity(i)
        }

    }
    override fun reordenarAlfabeticoView(){
        presenter.reordenarAlfabetico()
    }
    override fun reordenaPeloCodigo(){
        presenter.reordenaCodigo()
    }
    override fun atualizaView(){
        this.myListAdapter?.notifyDataSetChanged()
    }


    fun append(arr: Array<String>, element: String): Array<String> {
        val list: MutableList<String> = arr.toMutableList()
        list.add(element)
        return list.toTypedArray()
    }

}