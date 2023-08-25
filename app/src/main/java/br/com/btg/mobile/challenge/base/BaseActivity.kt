package br.com.btg.mobile.challenge.base

import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import br.com.arch.toolkit.delegate.viewProvider
import br.com.btg.mobile.challenge.R

open class BaseActivity(layoutId: Int) : AppCompatActivity(layoutId) {

    private val toolbar: Toolbar by viewProvider(R.id.toolbar)

    internal fun setUpToolbar(subtitle: String? = null, displayHome: Boolean = false) {
        setSupportActionBar(toolbar)
        supportActionBar?.apply {
            setDisplayHomeAsUpEnabled(displayHome)
            this.title = getString(R.string.app_name)
            this.subtitle = subtitle
        }
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            android.R.id.home -> {
                finish()
                return true
            }
        }
        return super.onOptionsItemSelected(item)
    }
}
