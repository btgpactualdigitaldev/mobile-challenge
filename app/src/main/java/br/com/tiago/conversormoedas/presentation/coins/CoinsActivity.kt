package br.com.tiago.conversormoedas.presentation.coins

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.core.content.ContextCompat
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import br.com.tiago.conversormoedas.R
import br.com.tiago.conversormoedas.data.respository.CoinsApiDataSource
import br.com.tiago.conversormoedas.presentation.data.BaseActivity
import kotlinx.android.synthetic.main.activity_coins.*
import kotlinx.android.synthetic.main.button_change.*
import kotlinx.android.synthetic.main.include_toolbar.*

class CoinsActivity: BaseActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_coins)

        setupToolbar(toolbarMain, R.string.coins_title, showBackButton = true)

        toolbarMain.setNavigationOnClickListener { onBackPressed() }

        val viewModel: CoinsViewModel = CoinsViewModel.ViewModelFactory(CoinsApiDataSource(this@CoinsActivity))
                .create(CoinsViewModel::class.java)

        viewModel.coinsLiveData.observe(this, Observer {
            it?.let { coins ->
                with(recyclerCoins) {

                    llButton.visibility = View.VISIBLE

                    layoutManager = LinearLayoutManager( this@CoinsActivity,
                        RecyclerView.VERTICAL, false)
                    setHasFixedSize(true)
                    adapter = CoinsAdapter(coins) { coin ->
                        val intent = Intent()
                        intent.putExtra("initials", coin.initials)
                        intent.putExtra("name", coin.name)
                        setResult(Activity.RESULT_OK, intent)
                        finish()
                    }
                }
            }
        })

        viewModel.viewFlipperLiveData.observe(this, Observer {
            it?.let {viewFlipper ->
                // aqui falamos qual filho do flipper tem q ser mostrado
                viewFlipperCoins.displayedChild = viewFlipper.first
                // na segunda posição defino qual texto vou mostrar
                viewFlipper.second?.let {errorMessageResId ->
                    textViewError.text = getString(errorMessageResId)
                }
            }
        })

        btnName.setOnClickListener {
            btnName.background = ContextCompat.getDrawable(this@CoinsActivity, R.drawable.shape_on_right)
            btnInitials.background = ContextCompat.getDrawable(this@CoinsActivity, R.drawable.shape_off_left)
            btnInitials.setTextColor(ContextCompat.getColorStateList(this@CoinsActivity, R.color.colorPrimary))
            btnName.setTextColor(ContextCompat.getColorStateList(this@CoinsActivity, R.color.colorText))

            viewModel.getCoinsDB(type = "name")
        }

        btnInitials.setOnClickListener {
            btnName.background = ContextCompat.getDrawable(this@CoinsActivity, R.drawable.shape_off_right)
            btnInitials.background = ContextCompat.getDrawable(this@CoinsActivity, R.drawable.shape_on_left)
            btnInitials.setTextColor(ContextCompat.getColorStateList(this@CoinsActivity, R.color.colorText))
            btnName.setTextColor(ContextCompat.getColorStateList(this@CoinsActivity, R.color.colorPrimary))

            viewModel.getCoinsDB(type = "init")
        }

        viewModel.getCoinsDB(type = null)
    }

    override fun onBackPressed() {
        super.onBackPressed()
        setResult(Activity.RESULT_CANCELED)
        finish()
    }

    companion object {

        fun getStartIntent(context: Context) : Intent {
            return Intent(context, CoinsActivity::class.java)
        }
    }
}