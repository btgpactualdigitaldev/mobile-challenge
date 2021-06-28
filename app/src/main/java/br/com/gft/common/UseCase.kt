package br.com.gft.common

abstract class UseCase <in T, out O>  {
    abstract suspend fun execute(params: T) : O
    suspend operator fun invoke(params: T) : O {
        return execute(params)
    }
}
