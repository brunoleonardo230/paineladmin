@extends('app')

@section('content')
<div class="loginColumns">
    <div class="row">
        <div>
                <div class="ibox-content">
                    @if (count($errors) > 0)
                        <div class="alert alert-danger">
                            <strong>Whoops!</strong> Algo deu errado.<br><br>
                            <ul>
                                @foreach ($errors->all() as $error)
                                    <li>{{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                    @endif

                    <form class="m-t" role="form" method="POST" action="{{ url('/password/reset') }}">
                        <input type="hidden" name="_token" value="{{ csrf_token() }}">
                        <input type="hidden" name="token" value="{{ $usuario->remember_token }}">

                        <div class="form-group">
                            <div class="input-group m-b">
                                <input type="email" name="str_email"  placeholder="E-mail" class="form-control" required > <span class="input-group-addon"><span class="fa fa-at"></span></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group m-b">
                                <input type="password" name="str_senha"  placeholder="Nova Senha" class="form-control" required> <span class="input-group-addon"><span class="fa fa-lock"></span></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group m-b">
                                <input type="password" name="str_senha_confirmation"  placeholder="Repita a Nova Senha" class="form-control" required> <span class="input-group-addon"><span class="fa fa-lock"></span></span>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary block full-width m-b">
                            Alterar Senha
                        </button>
                    </form>
                </div>
    </div>
</div>
@endsection
