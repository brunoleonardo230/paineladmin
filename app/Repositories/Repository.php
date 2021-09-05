<?php

namespace App\Repositories;

class Repository
{
    public function all()
    {
        return $this->model()->all();
    }

    public function create($dados)
    {
        return $this->model()->create($dados);
    }

    public function delete($id)
    {
        return ($this->model()->find($id))->delete();
    }

    public function lists($value, $key)
    {
        $dados = $this->model()->select($value, $key)->get();

        $dados = $dados->pluck($value, $key);

        return $dados;
    }
}