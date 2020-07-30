package br.com.mobilechallenge.view

import android.app.Activity
import android.content.DialogInterface
import android.os.Bundle
import android.os.PersistableBundle
import android.view.KeyEvent

import androidx.appcompat.app.ActionBar
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar

import br.com.mobilechallenge.R
import br.com.mobilechallenge.utils.UtilsAnimation

abstract class DefaultActivity(resourceView: Int) : AppCompatActivity(resourceView) {
    private var actionBar: ActionBar? = null
    private var mToolbar: Toolbar? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initViews()
        initViewModel()
    }

    fun setupToolBar(resource: Int) {
        mToolbar = findViewById(resource)
        setSupportActionBar(mToolbar)
        actionBar = supportActionBar
    }

    fun setActionBarHome()       { actionBar?.setHomeButtonEnabled(true) }
    fun setActionBarHomeButton() { actionBar?.setDisplayHomeAsUpEnabled(true) }

    fun setActionBarNotHome()       { actionBar?.setHomeButtonEnabled(false) }
    fun setActionBarNotHomeButton() { actionBar?.setDisplayHomeAsUpEnabled(false) }

    fun setActionBarTitle(title: String) { actionBar?.title = title }
    fun setActionBarTitle(title: Int)    { actionBar?.title = getString(title) }

    fun setActionBarSubTitle(title: String) { actionBar?.subtitle = title }
    fun setActionBarSubTitle(title: Int)    { actionBar?.subtitle = getString(title) }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        return if (keyCode == KeyEvent.KEYCODE_BACK) {
            back(Activity.RESULT_CANCELED)
            true
        }
        else {
            super.onKeyDown(keyCode, event)
        }
    }

    /**
     * Method to animate activity Left to Right
     */
    fun animLeftToRight() {
        UtilsAnimation.leftToRight(this)
    }

    /**
     * Method to animate activity Right to Left
     */
    fun animRightToLeft() {
        UtilsAnimation.rightToLeft(this)
    }

    fun msgBox(msg: String) {
        AlertDialog.Builder(this, R.style.AlertDialogTheme)
            .apply {
                setTitle(R.string.btn_error)
                setMessage(msg)
                setCancelable(false)
                setPositiveButton("OK") { dialog1: DialogInterface?, whichButton: Int -> {} }
                create().show()
            }
    }

    abstract fun back(resultCode: Int)
    abstract fun initViews()
    abstract fun initViewModel()
}