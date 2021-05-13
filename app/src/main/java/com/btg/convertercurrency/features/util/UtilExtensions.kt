package com.btg.convertercurrency.features.util

import android.app.Activity
import android.content.Context
import android.os.Bundle
import android.os.Parcelable
import android.view.WindowManager
import android.widget.PopupWindow
import androidx.annotation.IdRes
import androidx.lifecycle.MutableLiveData
import androidx.navigation.NavController
import androidx.navigation.NavOptions
import androidx.navigation.Navigator
import java.time.LocalDateTime
import java.time.OffsetDateTime
import java.time.ZoneOffset
import java.util.concurrent.Executors

fun NavController.navigateSafe(
    @IdRes resId: Int,
    args: Bundle? = null,
    navOptions: NavOptions? = null,
    navExtras: Navigator.Extras? = null
) {
    val action = currentDestination?.getAction(resId) ?: graph.getAction(resId)
    if (action != null && currentDestination?.id != action.destinationId) {
        navigate(resId, args, navOptions, navExtras)
    }
}

fun <T : Any?> MutableLiveData<T>.default(initialValue: T) = apply { setValue(initialValue) }

fun Long.toOffsetDateTime(): OffsetDateTime{
    return OffsetDateTime
        .of(
            LocalDateTime.ofEpochSecond(
            this,
            0,
            ZoneOffset.UTC), ZoneOffset.UTC)
}

fun <T> Event<T>.getMamipuladeEvent() : Event<T>{
    return this.also { it.getContentIfNotHandled() }
}

/**
 * Retorna uma instância a partir da Intent de entrada e extrai o extra a partir do tipo [T] mapeado para a a entrada [key] sem valor default.
 * Ex:
 * class LoginActivity : Activity() {
 *     private val name by extra<String>("userName")
 * }
 */
inline fun <reified T> Activity.extra(key: String): Lazy<T> = lazy {
    val value = intent.extras?.get(key)
    if (value is T) {
        value
    } else {
        throw IllegalArgumentException(
            "Couldn't find extra with key \"$key\" from type " +
                    T::class.java.canonicalName
        )
    }
}
/**
 * Retorna uma instância a partir da Intent de entrada e extrai o extra a partir do tipo [T] mapeado para a a entrada [key] sem valor default.
 * Ex:
 * class LoginActivity : Activity() {
 *     private val name by extra<String>("userName")
 * }
 */
inline fun <reified T : Parcelable> Activity.parcelableExtra(key: String): Lazy<T> = lazy {
    val value = intent.getParcelableExtra<T>(key)
    if (value is T ) {
        value
    } else {
        throw IllegalArgumentException(
            "Couldn't find extra with key \"$key\" from type " +
                    T::class.java.canonicalName
        )
    }
}

/**
 * Retorna uma instância a partir da Intent de entrada e extrai o extra a partir do tipo [T] mapeado para a a entrada [key], se não for encontrado o valor será retornado
 * o resultado da função [default]
 * Ex:
 * class LoginActivity : Activity() {
 *     private val name by extra<String>("userName")
 * }
 */
inline fun <reified T> Activity.extra(key: String, crossinline default: () -> T): Lazy<T> = lazy {
    val value = intent.extras?.get(key)
    if (value is T) value else default()
}

fun PopupWindow.dimBehind(dimAmount: Float = 0.6f) {
    val container = contentView.rootView
    val context = contentView.context
    val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
    val layoutParams = container.layoutParams as WindowManager.LayoutParams
    layoutParams.flags = layoutParams.flags or WindowManager.LayoutParams.FLAG_DIM_BEHIND
    layoutParams.dimAmount = dimAmount
    windowManager.updateViewLayout(container, layoutParams)
}