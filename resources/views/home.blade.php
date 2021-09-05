@extends('layouts.simple')

@section('content')
    <div class="row">
        <div class="ibox float-e-margins">
            <div class="ibox-content">
                <h1>Meus aplicativos</h1>
                <div class="row">
                    @foreach($modulos as $key => $modulo)
                        <div class="col-lg-3">
                            <a title="Acessar {{ $modulo->str_descricao }}" href="{{ url($modulo->str_nome.'/index') }}">
                                <div class="widget navy-bg p-lg text-center">
                                    <div class="m-b-md">
                                        <div class="form-group">
                                            <i class="fa @if($modulo->str_icone) {{$modulo->str_icone}} @else fa-shield @endif fa-4x"></i>
                                        </div>
                                        <h1 class="font-bold no-margins modulo">{{ ucfirst($modulo->str_nome_fantasia) }}</h1>
                                        <small>{{ $modulo->str_descricao }}</small>
                                    </div>
                                </div>
                            </a>
                        </div>
                    @if(($key + 1) % 4 == 0) </div><div class="row"> @endif
                    @endforeach
                </div>
            </div>
        </div>
    </div>   

@stop

@section('scripts')
<script>
    $('li.notification').click(function(){
        $(this).find('span').hide();
        $("#notification").modal();
    });

    $('input.msg_readed').change(function(){
        var input = $(this);

        if(input.is(':checked')) {
    
            var msgID = $(this).data('msg');

            $('i.loading-readed').show();
            
            $.post("{{url('/admin/usuarios/messagereaded')}}", {msgID : msgID, '_token': '{{csrf_token()}}'}, function(d){
                $('i.loading-readed').hide();
            }, 'json');
    
        }

    });

</script>

<script>
    var storage = localStorage;
    
    @if(($total = \App\Models\Geral\Mensagem::count() - \Auth::user()->mensagens()->count()) <= 0)
        storage.setItem('view_notification', true);
    @endif

    if(!storage.getItem('view_notification')) {
        storage.setItem('view_notification', true);
        $("#notification").modal();
    }

    @if($total >= 1)
       // $("#notification").modal();        
    @endif
</script>
@stop