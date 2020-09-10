package com.example.conversordemoeda.view

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.conversordemoeda.R
import com.example.conversordemoeda.model.repositorio.STATUS
import com.example.conversordemoeda.view.adapter.AdapterListaDeMoedas
import com.example.conversordemoeda.view.adapter.InteracaoComLista
import com.example.conversordemoeda.view.extensions.hide
import com.example.conversordemoeda.view.extensions.show
import com.example.conversordemoeda.viewmodel.ListaDeMoedasViewModel
import kotlinx.android.synthetic.main.activity_lista_de_moedas.*
import org.koin.androidx.viewmodel.ext.android.viewModel

class ListaDeMoedasActivity : AppCompatActivity(), LifecycleObserver {

    private val viewModel: ListaDeMoedasViewModel by viewModel()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_lista_de_moedas)

        initRecyclerView()
        initObserver()

        lifecycle.addObserver(this)
    }

    private fun initObserver() {
        viewModel.cambioData.observe(this, Observer {
            when (it.status) {
                STATUS.OPEN_LOADING -> {
                    progressBar.show()
                }
                STATUS.SUCCESS -> {
                    progressBar.hide()
                    rvMoeda.show()
                    tvErrorMensage.hide()
                    (rvMoeda.adapter as AdapterListaDeMoedas).apply {
                        mValues = it.cambioMap
                        notifyDataSetChanged()
                    }
                }
                STATUS.ERROR -> {
                    progressBar.hide()
                    rvMoeda.hide()
                    tvErrorMensage.text = it.errorMessage
                    tvErrorMensage.show()
                }
            }
        })
    }

    private fun initRecyclerView() {
        rvMoeda.apply {
            layoutManager = LinearLayoutManager(this@ListaDeMoedasActivity)
            adapter = AdapterListaDeMoedas(interacaoComLista = object : InteracaoComLista<String> {
                override fun selecionou(itemSelecionado: String) {
                    setResult(Activity.RESULT_OK, Intent().putExtra(CODIGO_MOEDA_SELECIONADA, itemSelecionado))
                    finish()
                }
            })
        }
    }

    companion object {
        const val CODIGO_MOEDA_SELECIONADA = "codigoMoedaSelecionada"
    }
}