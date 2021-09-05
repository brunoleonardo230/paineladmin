@extends('layouts.email')

@section('content')
    <tbody>
    <tr>
        <td style="font-size: 18px; color: #fff; font-weight: 500; padding: 20px; text-align: center; border-radius: 3px 3px 0 0; background: #1ab394;">
            SUA SENHA TEMPORÁRIA
        </td>
    </tr>
    <tr>
        <td style="padding: 20px;">
            <table width="100%" cellpadding="0" cellspacing="0">
                <tbody>
                <tr>
                    <td style="padding: 0 0 20px;">
                        <h2>Olá <strong>{{$nome}}</strong></h2>
                        <p>Sua senha foi resetada em nosso painel administrativo.
                        Utilize a senha abaixo, para acessar seu usário em nosso painel de controle</p>
                        <p>
                            Senha: <strong>{{$password}}</strong>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 0 0 20px; text-align: center;">
                        <a href="{{ url('auth/login') }}" style="text-decoration: none;color: #FFF;background-color: #1ab394;border: solid #1ab394;border-width: 5px 10px;line-height: 2;text-align: center;cursor: pointer;display: inline-block;border-radius: 5px;">
                            Clique aqui para acessar o painel.
                        </a>
                    </td>
                </tr>
                </tbody>
            </table>
        </td>
    </tr>
    </tbody>
@stop