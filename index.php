<?php

include __DIR__ . '/../vendor/autoload.php';

$kirby = new Kirby([
  'roots' => [
    'index'    => __DIR__,
    
    'base'     => $base    = dirname(__DIR__),
    
    'content'  => $base . '/content',
    'plugins'  => $base . '/plugins',
    'site'     => $base . '/site',

    'storage'  => $storage = $base . '/storage',
    'accounts' => $storage . '/accounts',
    'cache'    => $storage . '/cache',
    'sessions' => $storage . '/sessions',
    'logs'     => $storage . '/logs',
  ]
]);

echo $kirby->render();
