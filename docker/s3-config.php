<?php

/**
 * S3 object storage configuration for Skafld Cloud.
 *
 * Reads OBJECTSTORE_S3_* from environment (provided by Railway Buckets).
 * When configured, all user files are stored in S3 instead of local disk,
 * ensuring data persists across container redeployments.
 *
 * Required env vars: OBJECTSTORE_S3_BUCKET, OBJECTSTORE_S3_KEY, OBJECTSTORE_S3_SECRET
 * Optional env vars: OBJECTSTORE_S3_HOST, OBJECTSTORE_S3_PORT, OBJECTSTORE_S3_REGION, OBJECTSTORE_S3_SSL
 */

$s3_bucket = getenv('OBJECTSTORE_S3_BUCKET');
$s3_key    = getenv('OBJECTSTORE_S3_KEY');
$s3_secret = getenv('OBJECTSTORE_S3_SECRET');

if ($s3_bucket && $s3_key && $s3_secret) {
  $CONFIG = [
    'objectstore' => [
      'class' => 'OC\\Files\\ObjectStore\\S3',
      'arguments' => [
        'bucket'     => $s3_bucket,
        'key'        => $s3_key,
        'secret'     => $s3_secret,
        'hostname'   => getenv('OBJECTSTORE_S3_HOST') ?: 'storage.railway.app',
        'port'       => (int)(getenv('OBJECTSTORE_S3_PORT') ?: 443),
        'use_ssl'    => filter_var(getenv('OBJECTSTORE_S3_SSL') ?: 'true', FILTER_VALIDATE_BOOLEAN),
        'region'     => getenv('OBJECTSTORE_S3_REGION') ?: 'sjc',
        'use_path_style' => true,
        'autocreate' => false,
      ],
    ],
  ];
}
