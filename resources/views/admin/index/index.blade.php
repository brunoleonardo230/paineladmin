@extends('layouts.admin')

@section('content')
    <div class="row form-group">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li>
                    <a href="{{url('/')}}">App</a>
                </li>
                <li class="active">
                    <strong>Admin</strong>
                </li>
            </ol>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="ibox float-e-margins">
                <div class="ibox-content text-center p-md">
                    <h2><span class="text-navy">Admin - </span>Sistema de administração</h2>
                    <p>
                        Utilize o menu do lado esquerdo para navegar pelo sistema.
                    </p>
                </div>
            </div>
        </div>
    </div>
@stop