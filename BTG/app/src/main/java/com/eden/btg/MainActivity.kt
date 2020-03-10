package com.eden.btg

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.ImageButton
import android.widget.Toast
import com.eden.btg.activity.ListaMoedasActivity
import com.eden.btg.model.Moeda
import com.google.android.material.textfield.TextInputEditText

class MainActivity : AppCompatActivity() {
    private val COD_BTN_ORIGEM = 1
    private val COD_BTN_DESTINO = 2

    private var moedaOrigem: Moeda = Moeda("BRL","Brazilian Real")
    private var moedaDestino: Moeda = Moeda("USD","United States Dollar")

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        findViewById<Button>(R.id.main_btn_moeda_origem).setOnClickListener { it.isClickable = false
                                                                              listaMoedas(COD_BTN_ORIGEM) }

        findViewById<Button>(R.id.main_btn_moeda_destino).setOnClickListener { it.isClickable = false
                                             listaMoedas(COD_BTN_DESTINO) }

        findViewById<ImageButton>(R.id.main_btn_moeda_troca).setOnClickListener { trocaMoedas() }

        findViewById<Button>(R.id.main_btn_moeda_converter).setOnClickListener{ converter() }

        atualizaBotoes()

    }

    private fun converter(){
        val vlrOrigem = findViewById<TextInputEditText>(R.id.main_edt_moeda_origem).text.toString().toDouble()
        val vlrOrigemEmDollar = moedaOrigem.vrDollar
        val vlrDestinoEmDollar = moedaDestino.vrDollar
        if (vlrOrigem > 0.0 && vlrDestinoEmDollar > 0.0 ) {
            findViewById<TextInputEditText>(R.id.main_edt_moeda_destino).setText(
                vlrDestinoEmDollar.times(vlrOrigem).div(vlrOrigemEmDollar).toString())
        }else{
            Toast.makeText(this,"Moedas sem valores válidos... selecione novamente",Toast.LENGTH_LONG).show()
        }
    }

    private fun trocaMoedas(){
        val aux: Moeda = moedaDestino.copy()
        moedaDestino = moedaOrigem.copy()
        moedaOrigem = aux.copy()

        atualizaBotoes()
    }

    private fun atualizaBotoes(){
        val btnOrigem = findViewById<Button>(R.id.main_btn_moeda_origem)
        val btnDestino = findViewById<Button>(R.id.main_btn_moeda_destino)
        val edtDestino = findViewById<EditText>(R.id.main_edt_moeda_destino)

        btnOrigem.text = moedaOrigem.sigla
        btnOrigem.isClickable = true
        btnDestino.text = moedaDestino.sigla
        btnDestino.isClickable = true
        edtDestino.text.clear()
    }

    private fun listaMoedas(btn: Int) {
        val intent = Intent(this, ListaMoedasActivity::class.java)
        startActivityForResult(intent, btn)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if(resultCode == Activity.RESULT_OK){
            val moeda = data?.getSerializableExtra("MOEDA") as Moeda
            when(requestCode){
                COD_BTN_ORIGEM  -> { moedaOrigem = moeda  }
                COD_BTN_DESTINO -> { moedaDestino = moeda }
            }
        }
        atualizaBotoes()
    }

}
