package academy.mukandrew.currencyconverter.presenter

import academy.mukandrew.currencyconverter.R
import academy.mukandrew.currencyconverter.presenter.fragments.CurrencyConvertFragment
import academy.mukandrew.currencyconverter.presenter.fragments.CurrencyListFragment
import academy.mukandrew.currencyconverter.presenter.models.CurrencyMethodType
import android.os.Bundle
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setupInitialFragment()
    }

    private fun setupInitialFragment() {
        supportFragmentManager
            .beginTransaction()
            .add(R.id.container, CurrencyConvertFragment())
            .commitNow()
    }

    fun changeFragmentToList(methodType: CurrencyMethodType) {
        supportFragmentManager
            .beginTransaction()
            .replace(R.id.container, CurrencyListFragment(methodType))
            .addToBackStack(CurrencyListFragment::class.java.name)
            .setCustomAnimations(
                android.R.anim.fade_in,
                android.R.anim.fade_out,
                android.R.anim.fade_out,
                android.R.anim.fade_in
            ).commit()
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when (item.itemId) {
            android.R.id.home -> true.also { onBackPressed() }
            else -> super.onOptionsItemSelected(item)
        }
    }
}