<?php
$redis = new Redis();
$redis->connect('127.0.0.1', 6379);

$redis->setOption(Redis::OPT_SERIALIZER, Redis::SERIALIZER_PHP);
$redis->setOption(Redis::OPT_COMPRESSION, Redis::COMPRESSION_LZF);

// Add test data
$redis->zAdd('test_key', 1, 'member1');
$redis->zAdd('test_key', 2, 'member2');

// This works fine
var_dump($redis->zRange('test_key', 0, -1));

// This crashes PHP
var_dump($redis->zRange('test_key', 0, -1, ['WITHSCORES' => true]));

// This also crashes
var_dump($redis->zRangeByScore('test_key', '-inf', '+inf', ['withscores' => true]));

// rawCommand also crashes or timeouts
var_dump($redis->rawCommand('ZRANGE', 'test_key', 0, -1, 'WITHSCORES'));
