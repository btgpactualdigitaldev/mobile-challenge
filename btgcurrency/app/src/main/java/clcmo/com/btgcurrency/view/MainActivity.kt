package clcmo.com.btgcurrency.view

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.MenuItem
import clcmo.com.btgcurrency.R
import clcmo.com.btgcurrency.util.constants.Constants
import clcmo.com.btgcurrency.view.fragment.CConverterFragment
import clcmo.com.btgcurrency.view.fragment.CListFragment

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        startConverterFragment()
    }

    private fun startConverterFragment() {
        supportFragmentManager
            .beginTransaction()
            .add(R.id.mainActivity, CConverterFragment())
            .commitNow()
    }

    fun convertFragmentToList(methodType: Constants.CMethodType) {
        supportFragmentManager
            .beginTransaction()
            .replace(R.id.mainActivity, CListFragment(methodType))
            .addToBackStack(CListFragment::class.java.name)
            .setCustomAnimations(
                android.R.anim.fade_in,
                android.R.anim.fade_out,
                android.R.anim.fade_out,
                android.R.anim.fade_in
            ).commit()
    }

    override fun onOptionsItemSelected(menuItem: MenuItem) = when (menuItem.itemId) {
        android.R.id.home -> true.also { onBackPressed() }
        else -> super.onOptionsItemSelected(menuItem)
    }
}