<?php 
namespace App\Log;

use Log;
use Monolog\Handler\StreamHandler;
use Illuminate\Http\Request;
use Monolog\Logger;

class CustomLog
{
	
	public static function log($message, $params = array(), $type = 1)
	{

		$path = array_filter(preg_split('/\//', $_SERVER["REQUEST_URI"]));
		$modulo = current($path);

		$monolog = new Logger($modulo);

		$path = storage_path() . '/logs/applications/' . $modulo;

	    $monolog->pushHandler(new StreamHandler($path . '/'.date('d-m-Y').'.log', Logger::DEBUG));

	    if($type == 1)
	    	$monolog->info($message, $params);

	    if($type == 2)
	    	$monolog->error($message, $params);
	}
}