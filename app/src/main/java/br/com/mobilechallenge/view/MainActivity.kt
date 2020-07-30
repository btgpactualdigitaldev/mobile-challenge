package br.com.mobilechallenge.view

import android.app.Activity
import android.content.Intent
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.view.inputmethod.EditorInfo
import android.widget.EditText
import android.widget.ImageView

import kotlinx.android.synthetic.main.activity_main.*

import br.com.mobilechallenge.R
import br.com.mobilechallenge.model.bean.ListBean
import br.com.mobilechallenge.presenter.live.MVP
import br.com.mobilechallenge.presenter.live.Presenter
import br.com.mobilechallenge.utils.Constantes
import br.com.mobilechallenge.utils.MaskDecimal
import br.com.mobilechallenge.utils.Utils

class MainActivity : DefaultActivity(R.layout.activity_main), MVP.View {
    private lateinit var presenter: MVP.Presenter

    private lateinit var editItemFrom: EditText
    private lateinit var editItemTo: EditText
    private lateinit var editValueFrom: EditText
    private lateinit var editValueTo: EditText

    private var itemFrom: ListBean? = null
    private var itemTo: ListBean? = null

    override fun initViews() {
        setupToolBar(R.id.toolbar)
        setActionBarTitle("")
        setActionBarSubTitle("")

        editItemFrom = findViewById(R.id.editItemFrom)
        editItemTo   = findViewById(R.id.editItemTo)
        editValueTo  = findViewById(R.id.editValueTo)

        progress.hide()

        findViewById<ImageView>(R.id.btnItemFrom)
            .setOnClickListener {
                openList(Constantes.CURRENCY_FROM)
            }

        findViewById<ImageView>(R.id.btnItemTo)
            .setOnClickListener {
                openList(Constantes.CURRENCY_TO)
            }

        editValueFrom = findViewById(R.id.editValueFrom)
        editValueFrom.addTextChangedListener(MaskDecimal(editValueFrom))
        editValueFrom.setOnEditorActionListener{ textView, actionId, keyEvent ->
            when(actionId) {
                EditorInfo.IME_ACTION_DONE -> {
                    actionDone()
                    false
                }
                else -> false
            }
        }

        btnConvert.setOnClickListener { actionDone() }

        presenter = Presenter()
        presenter.setView(this)
    }

    override fun initViewModel() {
    }

    private fun actionDone() {
        val amount: Double = editValueFrom.editableText.toString()
            .replace("$","")
            .replace(",","")
            .toDouble()
        val from: String = editItemFrom.editableText.toString()
        val to: String = editItemTo.editableText.toString()

        if (from.isBlank() || from.isEmpty()) {
            msgBox(getString(R.string.txt_error2))
            return
        }
        if (to.isBlank() || to.isEmpty()) {
            msgBox(getString(R.string.txt_error3))
            return
        }
        if (amount == 0.00) {
            msgBox(getString(R.string.txt_error1))
            return
        }

        presenter.retrieveData(itemFrom, itemTo, amount)
    }

    override fun back(resultCode: Int) { finish() }

    override fun showProgressBar(visible: Int) {
        when(visible) {
            View.VISIBLE -> progress.show()
            View.GONE    -> progress.hide()
        }
    }

    private fun openList(requestCode: Int) {
        val intent = Intent(this, ListActivity::class.java)
        startActivityForResult(intent, requestCode)
        animRightToLeft()
    }

    override fun resultData(requestCode: Int, item: ListBean?) {
        when(requestCode) {
            Constantes.CURRENCY_FROM -> {
                val text = "${item?.code} - ${item?.description}"
                itemFrom = item
                editItemFrom.setText(text)
            }
            Constantes.CURRENCY_TO -> {
                val text = "${item?.code} - ${item?.description}"
                itemTo = item
                editItemTo.setText(text)
            }
        }
    }

    override fun resultCalc(price: Double) {
        val text = "$${Utils.roundOffDecimal(price)}"
        editValueTo.setText(text)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (resultCode == Activity.RESULT_OK) {
            presenter.resultData(requestCode, data)
        }
    }

    /**
     * Menu
     */
    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.main_menu, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when(item.itemId) {
            R.id.action_clear -> {
                itemFrom = null
                itemTo   = null
                editItemFrom.setText("")
                editItemTo.setText("")
                editValueTo.setText(getString(R.string.txt_zero))
                editValueFrom.setText(getString(R.string.txt_zero))
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }
}