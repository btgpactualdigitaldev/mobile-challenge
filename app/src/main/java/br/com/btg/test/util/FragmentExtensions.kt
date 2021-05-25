package br.com.btg.test.util

import androidx.fragment.app.Fragment

inline fun <reified T> Fragment.argument(key: String): Lazy<T> = lazy {
    val value = arguments?.get(key)
    if (value is T) {
        value
    } else {
        throw IllegalArgumentException(
            "Couldn't find extra with key \"$key\" from type " +
                T::class.java.canonicalName
        )
    }
}

inline fun <reified T> Fragment.argument(key: String, crossinline default: () -> T): Lazy<T> =
    lazy {
        val value = arguments?.get(key)
        if (value is T) value else default()
    }

inline fun <reified T> Fragment.extra(key: String): Lazy<T> = lazy {
    val value = activity?.intent?.extras?.get(key)
    if (value is T) {
        value
    } else {
        throw IllegalArgumentException(
            "Couldn't find extra with key \"$key\" from type " +
                T::class.java.canonicalName
        )
    }
}

inline fun <reified T> Fragment.extra(key: String, crossinline default: () -> T): Lazy<T> = lazy {
    val value = activity?.intent?.extras?.get(key)
    if (value is T) value else default()
}
