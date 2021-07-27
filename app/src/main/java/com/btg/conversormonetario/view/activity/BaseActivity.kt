package com.btg.conversormonetario.view.activity

import android.animation.ValueAnimator
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.View.GONE
import android.view.View.VISIBLE
import android.view.animation.Animation
import android.view.animation.TranslateAnimation
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import com.btg.conversormonetario.R
import com.btg.conversormonetario.shared.getWidthSizeScreen
import com.btg.conversormonetario.shared.observeNonNull
import com.btg.conversormonetario.view.viewmodel.BaseViewModel
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.activity_base.*
import org.koin.androidx.viewmodel.ext.android.getViewModel
import java.lang.reflect.ParameterizedType
import kotlin.reflect.KClass

abstract class BaseActivity<T : BaseViewModel> : AppCompatActivity() {
    val viewModel: T by lazy { getViewModel(viewModelClass()) }

    private var snackbar: Snackbar? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        super.setContentView(R.layout.activity_base)

        changeStatusBarColor()
        viewModel.setContext(this)
        viewModel.initViewModel()
    }

    override fun setContentView(layoutResID: Int) {
        fmlBaseLayout.addView(LayoutInflater.from(this).inflate(layoutResID, null, false))
        setViewModel()
    }

    @Suppress("UNCHECKED_CAST")
    private fun viewModelClass(): KClass<T> {
        return ((javaClass.genericSuperclass as ParameterizedType)
            .actualTypeArguments[0] as Class<T>).kotlin
    }

    private fun showInternetSnackbar(isConnected: Boolean = false) {
        if (!isConnected)
            showSnackbar()
        else
            dismissSnackbar()
    }

    private fun showSnackbar() {
        snackbar =
            Snackbar.make(fmlBaseLayout, R.string.all_connection_lost, Snackbar.LENGTH_INDEFINITE)
        snackbar!!.view.setBackgroundColor(ContextCompat.getColor(this, R.color.darkRed))
        snackbar!!.show()
    }

    private fun dismissSnackbar() {
        snackbar?.dismiss()
    }

    private fun changeStatusBarColor() {
        window.statusBarColor = ContextCompat.getColor(this, R.color.colorPrimary)
        window.navigationBarColor = ContextCompat.getColor(this, R.color.colorPrimary)
    }

    private fun makeAnimationX(duration: Long, view: View) {
        val animation = TranslateAnimation(
            Animation.ABSOLUTE, 1 - getWidthSizeScreen(this),
            Animation.ABSOLUTE, 1 + getWidthSizeScreen(this),
            Animation.ABSOLUTE, 0F,
            Animation.ABSOLUTE, 0F
        )
        animation.duration = duration
        animation.fillAfter = true
        animation.startOffset = 250
        animation.repeatCount = Animation.INFINITE
        animation.repeatMode = Animation.INFINITE

        view.startAnimation(animation)
    }

    fun makeAnimationY(view: View, isReverse: Boolean) {
        val animation = TranslateAnimation(
            Animation.ABSOLUTE, 0F,
            Animation.ABSOLUTE, 0F,
            Animation.ABSOLUTE, if (isReverse) 0F else -250F,
            Animation.ABSOLUTE, if (isReverse) -250F else 0F
        )
        animation.duration = 150
        animation.fillAfter = true
        animation.repeatMode = Animation.ABSOLUTE

        view.startAnimation(animation)
    }

    fun makeAnimationSlideUpAndDown(view: View, isSlideUp: Boolean) {
        val va = if (isSlideUp) ValueAnimator.ofInt(0, 300) else ValueAnimator.ofInt(300, 0)
        va.duration = 400
        va.addUpdateListener { animation ->
            val value = animation.animatedValue as Int
            view.layoutParams.height = value
            view.requestLayout()
        }
        va.start()
    }

    private fun animateLoading() {
        makeAnimationX(800, vewBaseLoadingFirst)
        makeAnimationX(1400, vewBaseLoadingSecond)
        makeAnimationX(1200, vewBaseLoadingThird)
    }

    private fun showLoading() {
        if (lltBaseLoading.visibility == GONE) {
            lltBaseLoading.visibility = VISIBLE
            animateLoading()
            lltBaseLoading.setOnClickListener(null)
        } else {
            return
        }
    }

    private fun hideLoading() {
        if (lltBaseLoading.visibility == VISIBLE)
            lltBaseLoading.visibility = GONE
        else
            return
    }

    private fun setViewModel() {
        viewModel.showLoader.observeNonNull(this) {
            if (it) showLoading() else hideLoading()
        }

        viewModel.appHasInternet.observeNonNull(this) { showInternetSnackbar(it) }

        viewModel.startConnectionListener()
    }
}
