<?php

/**
 * Redis caching and file locking configuration for Skafld Cloud.
 *
 * Reads REDIS_URL from environment (provided by Railway's managed Redis).
 * Falls back gracefully to APCu-only if Redis is not available.
 */

$redis_url = getenv('REDIS_URL');

if ($redis_url) {
  $parsed = parse_url($redis_url);

  $CONFIG = [
    'memcache.local'       => '\OC\Memcache\APCu',
    'memcache.distributed' => '\OC\Memcache\Redis',
    'memcache.locking'     => '\OC\Memcache\Redis',
    'redis' => [
      'host'     => $parsed['host'] ?? 'localhost',
      'port'     => $parsed['port'] ?? 6379,
      'password'  => $parsed['pass'] ?? '',
      'dbindex'  => 0,
      'timeout'  => 1.5,
      'read_timeout' => 1.5,
    ],
  ];
} else {
  $CONFIG = [
    'memcache.local' => '\OC\Memcache\APCu',
  ];
}
