package com.marcoaureliobueno.converterbtg.view

import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Color
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import com.marcoaureliobueno.converterbtg.R
import com.marcoaureliobueno.converterbtg.mvp.MainMVP
import com.marcoaureliobueno.converterbtg.presenter.MainPresenter
import kotlinx.android.synthetic.main.activity_main.*
import java.math.BigDecimal
import java.math.RoundingMode

class MainActivity : AppCompatActivity() , MainMVP.View{

    private val presenter: MainMVP.Presenter by lazy {
        MainPresenter(
            this
        )
    }
    val PREFS_FILENAME = "com.marcoaureliobueno.converterbtg.prefs"
    var prefs: SharedPreferences? = null

    var currdeuse = String()
    var currparause = String()
    lateinit var edvalor : EditText
    lateinit var resultado : TextView
    var alert : AlertDialog? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        prefs = this.getSharedPreferences(PREFS_FILENAME, 0)

        btnconverter.isEnabled = false
        //btnconverter.setBackgroundColor(Color.GRAY)
        presenter.listCurrencies();
        currdeuse = "semvalor"
        currparause = "semvalor"
        edvalor = findViewById(R.id.valor)
        resultado = findViewById(R.id.resultado)
        btnde.setOnClickListener{openListCorrenciesDe() }
        btnpara.setOnClickListener{openListCorrenciesPara()}
        btnconverter.setOnClickListener{converte()}

        if (!prefs!!.contains("setado")){
            prefs!!.edit().putInt("setado", 1).apply()
            prefs!!.edit().putString("currde", "semvalor").apply()
            prefs!!.edit().putString("currpara", "semvalor").apply()
            prefs!!.edit().putString("operacao", "semvalor").apply()
        }else{
            currdeuse = prefs!!.getString("currde", "semvalor").toString()
            currparause = prefs!!.getString("currpara", "semvalor").toString()
            if (!currdeuse.equals("semvalor")){
                btnde.setText(currdeuse)
                if (!currparause.equals("semvalor")) {
                    btnpara.setText(currparause)

                    btnconverter.isEnabled = true
                    btnconverter.setBackgroundResource(R.drawable.roundedbutton)

                }
            }
        }
        //presenter.setLit(intent.getSerializableExtra("lista") as ArrayList<Currency>)

    }

    fun openListCorrenciesDe() {
        if (!presenter.getListaCurrencies().isEmpty()) {

            val i = Intent(this@MainActivity, ListCurrenciesActivity::class.java)
            i.putExtra("listacurr", presenter.getListaCurrencies())
            i.putExtra("operacao", "de")
            startActivity(i)
            finish()
        }
    }

    fun openListCorrenciesPara() {
        if (!presenter.getListaCurrencies().isEmpty()) {

            //prefs.edit().putString("operacao", "para").apply()

            val i = Intent(this@MainActivity, ListCurrenciesActivity::class.java)
            i.putExtra("listacurr", presenter.getListaCurrencies())
            i.putExtra("operacao", "para")
            startActivity(i)
            finish()
        }
    }

    override fun converte() {
        println ("ainda nao implementado")
        val currdeenvia = prefs!!.getString("currde", "semvalor")
        val currparaenvia = prefs!!.getString("currpara", "semvalor")
        val valor = edvalor.text.toString()
        if (currdeenvia != null && currparaenvia != null) {
            if (validaCampos()) {
                alert = redAlertCritical2("Enviando Dados", "Aguarde o término da operação")
                presenter.enviaParaConverter(currdeenvia, currparaenvia, valor)
            }
        }else{
            Toast.makeText(this,"Escolas as Moedas para Conversão", Toast.LENGTH_LONG).show()
        }
    }
    override fun validaCampos() : Boolean{
        var ret : Boolean = true
        val valorchk = edvalor.text.toString()
        if (valorchk==""){
            ret = false
            redAlertCritical("Parâmetros", "Preencha o campo valor.")
            //Toast.makeText(this, "Preencha o campo valor.", Toast.LENGTH_LONG).show()
        }






        return ret
    }
    override fun retornaValorResultado(valor : Double){
        if (alert != null) {
            alert?.dismiss()
        }
        val decimal = BigDecimal(valor).setScale(3, RoundingMode.HALF_EVEN)

        resultado.setText(decimal.toString())
    }

    fun redAlertCritical(title: String, msg: String) {
        val builder = AlertDialog.Builder(this)
        builder.setTitle(title)
        builder.setMessage(msg)
        //builder.setPositiveButton("OK", DialogInterface.OnClickListener(function = x))

        builder.setPositiveButton("Sim") { dialog, which ->
            Toast.makeText(applicationContext,
                "Sim", Toast.LENGTH_SHORT).show()
        }

        builder.setNegativeButton("Não") { dialog, which ->
            Toast.makeText(applicationContext,
                "Não", Toast.LENGTH_SHORT).show()
        }

        /*builder.setNeutralButton("Outro") { dialog, which ->
            Toast.makeText(applicationContext,
                "OUtro", Toast.LENGTH_SHORT).show()
        }*/
        builder.show()
    }
    fun redAlertCritical2(title: String, msg: String): AlertDialog? {
        val builder = AlertDialog.Builder(this)
        builder.setTitle(title)
        builder.setMessage(msg)
        //builder.setPositiveButton("OK", DialogInterface.OnClickListener(function = x))

        /*builder.setPositiveButton(android.R.string.yes) { dialog, which ->
            Toast.makeText(applicationContext,
                android.R.string.yes, Toast.LENGTH_SHORT).show()
        }

        builder.setNegativeButton(android.R.string.no) { dialog, which ->
            Toast.makeText(applicationContext,
                android.R.string.no, Toast.LENGTH_SHORT).show()
        }*/

        /*builder.setNeutralButton("Outro") { dialog, which ->
            Toast.makeText(applicationContext,
                "OUtro", Toast.LENGTH_SHORT).show()
        }*/
        return builder.show()
    }

}