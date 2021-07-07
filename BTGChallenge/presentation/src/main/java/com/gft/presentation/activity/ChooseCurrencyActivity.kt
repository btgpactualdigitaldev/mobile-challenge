package com.gft.presentation.activity

import android.app.Activity
import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.gft.domain.entities.Resource
import com.gft.presentation.ListAdapter
import com.gft.presentation.R
import com.gft.presentation.databinding.ActivityChooseCurrencyBinding
import com.gft.presentation.viewmodel.ChooseCurrencyViewModel
import kotlinx.android.synthetic.main.activity_choose_currency.*
import org.koin.android.viewmodel.ext.android.viewModel

class ChooseCurrencyActivity : AppCompatActivity() {

    private val viewModel: ChooseCurrencyViewModel by viewModel()
    private lateinit var listAdapter: ListAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val binding: ActivityChooseCurrencyBinding =
            DataBindingUtil.setContentView(this, R.layout.activity_choose_currency)
        binding.lifecycleOwner = this

        binding.viewModel = viewModel

        listAdapter = ListAdapter(::onItemClick)
        recycler_view.layoutManager = LinearLayoutManager(this, RecyclerView.VERTICAL, false)
        recycler_view.adapter = listAdapter

        recycler_view.addItemDecoration(
            DividerItemDecoration(
                this@ChooseCurrencyActivity,
                LinearLayoutManager.VERTICAL
            )
        )
    }

    private fun onItemClick(codigo: String) {
        val fromTo = intent.getIntExtra("FROM_TO", -1)

        intent.putExtra("CODIGO", codigo)
        intent.putExtra("FROM_TO", fromTo)

        setResult(Activity.RESULT_OK, intent)
        finish()
    }

    override fun onStart() {
        super.onStart()

        viewModel.getLabelsLiveData().observe(this, Observer {
            when (it?.status) {
                Resource.Status.ERROR -> {
                    Toast.makeText(this, it.message, Toast.LENGTH_SHORT)
                        .show()
                }
                Resource.Status.SUCCESS -> {
                    it.data?.currencies?.let { it1 -> listAdapter.updateList(it1) }
                    progress_bar.visibility = View.INVISIBLE
                }
            }
        })
    }
}
