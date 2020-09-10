package com.example.conversordemoeda.view

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.Observer
import com.example.conversordemoeda.R
import com.example.conversordemoeda.model.repositorio.STATUS
import com.example.conversordemoeda.view.ListaDeMoedasActivity.Companion.CODIGO_MOEDA_SELECIONADA
import com.example.conversordemoeda.view.extensions.hide
import com.example.conversordemoeda.view.extensions.onTextChanged
import com.example.conversordemoeda.view.extensions.show
import com.example.conversordemoeda.viewmodel.MainViewModel
import kotlinx.android.synthetic.main.activity_main.*
import org.koin.androidx.viewmodel.ext.android.viewModel

class MainActivity : AppCompatActivity(), LifecycleObserver {
    val viewmodel: MainViewModel by viewModel()
    private val CAMBIO_DE_ORIGEM = 321
    private val CAMBIO_DE_DESTINO = 654

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        initObserver()

        etValor.onTextChanged { configurarImputDeValor(it)}

        btCambioOrigem.setOnClickListener {
            irParaTelaDeCambio(CAMBIO_DE_ORIGEM)
        }

        btCambioDestino.setOnClickListener {
            irParaTelaDeCambio(CAMBIO_DE_DESTINO)
        }

        lifecycle.addObserver(this)
    }

    private fun configurarImputDeValor(s: String) {
        if (s.isEmpty()) {
            viewmodel.setValor(0F)
            viewmodel.converterMoeda()
        } else {
            viewmodel.setValor(s.toFloat())
            viewmodel.converterMoeda()
        }
    }

    private fun initObserver() {
        viewmodel.cotacaoData.observe(this, Observer {
            when (it.status) {
                STATUS.OPEN_LOADING -> {
                    progressBarMain.show()
                }
                STATUS.SUCCESS -> {
                    progressBarMain.hide()
                    tvValorConvertido.text = it.valorConvertido.toString()
                }
                STATUS.ERROR -> {
                    progressBarMain.hide()
                    tvValorConvertido.text = it.errorMessage
                }
            }
        })
    }

    private fun irParaTelaDeCambio(tipodeCambio: Int) {
        startActivityForResult(Intent(this, ListaDeMoedasActivity::class.java), tipodeCambio)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        when (resultCode) {
            Activity.RESULT_OK -> {
                when (requestCode) {
                    CAMBIO_DE_ORIGEM -> {
                        data?.let {
                            it.getStringExtra(CODIGO_MOEDA_SELECIONADA)?.let { cambioSelecionado ->
                                btCambioOrigem.text = cambioSelecionado
                                viewmodel.definirCambioDeOrigem(cambioSelecionado)
                                viewmodel.converterMoeda()
                            }

                        }
                    }
                    CAMBIO_DE_DESTINO -> {
                        data?.let {
                            it.getStringExtra(CODIGO_MOEDA_SELECIONADA)?.let { cambioSelecionado ->
                                btCambioDestino.text = cambioSelecionado
                                viewmodel.definirCambioDeDestino(cambioSelecionado)
                                viewmodel.converterMoeda()
                            }
                        }
                    }
                }
            }
        }
    }
}