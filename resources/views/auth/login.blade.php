@extends('app')


<style type="text/css">
    h1.teste {
        color: blue;
        text-align: center;
    }
</style>


@section('content')

<div class="loginColumns">
    <div class="row">
        <!-- <div class="bgLogo"></div> -->
        <div>
            @if (count($errors) > 0)
                <div class="alert alert-danger">
                    
                    @if($errors->has('bad_credential'))
                        <strong>Whoops! </strong>Usuário e/ou senha incorreto(s). <br>
                    @endif

                    @if($errors->has('g-recaptcha-response'))
                        <strong>Whoops! </strong> Captcha não foi preenchido!
                    @endif
                    
                </div>
            @endif


            <div class="ibox-content">
                <div class="col-md-12 text-center form-group">
                    <h1 style="color: #c3c2c2"><i class="fa fa-lock"></i>  Acesso</h1>
                </div>
                <form class="m-t" role="form" method="POST" action="{{ url('/auth/login') }}">
                    <input type="hidden" name="_token" value="{{ csrf_token() }}">

                    <div class="form-group">
                        <div class="input-group m-b">
                            <input type="text" name="str_usuario"  placeholder="Usuário" class="form-control" required="" value="{{ old('str_usuario') }}"> <span class="input-group-addon"><span class="fa fa-user"></span></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-group m-b">
                            <input type="password" name="str_senha"  placeholder="Senha" class="form-control" required=""> <span class="input-group-addon"><span class="fa fa-lock"></span></span>
                        </div>
                    </div>
                    <hr>
                    <div class="form-group box-g-re-cap" style="text-align: center !important; display: table; padding-left: 18px;">
                        {{--@if(\Session::has('error_password'))--}}
                            {{--<p>Marque o captcha abaixo:</p>--}}
                            {{--{!! Recaptcha::render() !!}--}}
                        {{--@endif--}}
                    </div>

                    <button type="submit" class="btn btn-primary block full-width m-b">Login</button>

                    <a class="btn btn-link" href="{{ url('/password/email') }}">
                        <small>Esqueceu sua senha?</small>
                    </a>
                    <a class="btn btn-link" href="{{ url('pnae/consultar-documentos') }}">
                        <small>Deseja consultar documentos?</small>
                    </a>
                </form>
                <div class="row text-center">
                    <p class="m-t">
                        <small>BuildSoft ©{{ date('Y') }}</small>
                    </p>
                </div>
            </div>

            @if(config('app.debug'))
                <div class="col-md-12 form-group row text-center">
                    @include('components.ambient')
                </div>
            @endif
        </div>
    </div>
</div>
@endsection
