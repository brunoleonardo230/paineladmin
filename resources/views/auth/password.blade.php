@extends('app')

@section('content')
<div class="loginColumns">
    <div class="row">
        <div class="bgLogo"></div>
        <div>
        <div class="ibox-content">

                <p>Alterar Senha</p>

                    @if (session('status'))
                        <div class="alert alert-success">
                            {{ session('status') }}
                        </div>
                    @endif

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

                    <form class="m-t" role="form" method="POST" action="{{ url('/password/email') }}">
                        <input type="hidden" name="_token" value="{{ csrf_token() }}">

                        <div class="form-group">
                            <div class="input-group m-b">
                                <input type="email" name="email"  placeholder="E-mail" class="form-control" required="" > <span class="input-group-addon"><span class="fa fa-at"></span></span>
                            </div>
                        </div>



                        <button type="submit" class="btn btn-primary block full-width m-b">
                            Enviar Link Para o E-mail
                        </button>


                    </form>

            <p class="m-t">
                <small>Secretaria de Estado de Transparência e Controle © {{ date('Y') }}</small>
            </p>
        </div>
    </div>
</div>
@endsection
