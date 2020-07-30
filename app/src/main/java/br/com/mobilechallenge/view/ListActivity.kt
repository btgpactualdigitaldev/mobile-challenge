package br.com.mobilechallenge.view

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.recyclerview.widget.LinearLayoutManager

import kotlinx.android.synthetic.main.activity_list.*

import br.com.mobilechallenge.R
import br.com.mobilechallenge.model.bean.ListBean
import br.com.mobilechallenge.presenter.list.MVP
import br.com.mobilechallenge.presenter.list.Presenter
import br.com.mobilechallenge.view.adapter.ItemAdapter

class ListActivity : DefaultActivity(R.layout.activity_list), MVP.View {
    private lateinit var presenter: MVP.Presenter
    private lateinit var itemAdapter: ItemAdapter
    private var item: ListBean? = null

    override fun initViews() {
        setupToolBar(R.id.toolbar)
        setActionBarTitle("")
        setActionBarSubTitle("")
        setActionBarHomeButton()

        progressList.hide()

        presenter = Presenter()
        presenter.setView(this)
        presenter.retriveData()

        onLoad()
    }

    override fun initViewModel() {
    }

    private fun onLoad() {
        itemAdapter = ItemAdapter(this, presenter.items)

        val llayoutManager = LinearLayoutManager(this)
            llayoutManager.orientation = LinearLayoutManager.VERTICAL

        rv.apply {
            setHasFixedSize(true)
            layoutManager = llayoutManager
            adapter = itemAdapter
        }
    }

    fun result(item: ListBean) {
        this.item = item
        back(Activity.RESULT_OK)
    }

    override fun onSupportNavigateUp(): Boolean {
        back(Activity.RESULT_CANCELED)
        return true
    }

    override fun showProgressBar(visible: Int) {
        when(visible) {
            View.VISIBLE -> progressList.show()
            View.GONE    -> progressList.hide()
        }
    }

    override fun updateListRecycler() {
        itemAdapter.notifyDataSetChanged()
    }

    override fun back(resultCode: Int) {
        val bundle = Bundle()
            bundle.putParcelable("ITEM_RESULT", this.item)

        val intent = Intent(this, MainActivity::class.java)
            intent.putExtras(bundle)

        setResult(resultCode, intent)
        finish()
        animLeftToRight()
    }
}