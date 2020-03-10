package com.eden.btg.activity

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.eden.btg.R
import com.eden.btg.http.DownloadListaMoeda


class ListaMoedasActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_lista_moedas)

        DownloadListaMoeda(findViewById(R.id.activity_lista_moeda_recyclerview),this).execute()


    }

}



