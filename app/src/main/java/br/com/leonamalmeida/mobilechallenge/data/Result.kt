package br.com.leonamalmeida.mobilechallenge.data

/**
 * Created by Leo Almeida on 23/04/20.
 */

sealed class Result<T> {

    data class Loading<T>(val isLoading: Boolean) : Result<T>()

    data class Success<T>(val value: T) : Result<T>()

    data class Error<T>(val msg: Int) : Result<T>()
}