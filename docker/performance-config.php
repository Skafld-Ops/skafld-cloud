<?php

/**
 * Performance and operational configuration for Skafld Cloud.
 *
 * - Switches background jobs from AJAX to cron
 * - Sets default phone region (suppresses admin warning)
 * - Configures maintenance window for off-peak hours (UTC)
 * - Enables preview providers for media-rich workflows
 */
$CONFIG = [
  'default_phone_region' => 'US',
  'maintenance_window_start' => 8, // 8 UTC = midnight PST

  'enable_previews' => true,
  'enabledPreviewProviders' => [
    'OC\Preview\BMP',
    'OC\Preview\GIF',
    'OC\Preview\JPEG',
    'OC\Preview\PNG',
    'OC\Preview\XBitmap',
    'OC\Preview\MarkDown',
    'OC\Preview\TXT',
    'OC\Preview\OpenDocument',
    'OC\Preview\PDF',
    'OC\Preview\MSOffice2003',
    'OC\Preview\MSOfficeDoc',
    'OC\Preview\Image',
    'OC\Preview\SVG',
    'OC\Preview\Font',
    'OC\Preview\MP3',
    'OC\Preview\Movie',
    'OC\Preview\MKV',
    'OC\Preview\MP4',
    'OC\Preview\AVI',
    'OC\Preview\HEIC',
    'OC\Preview\Krita',
    'OC\Preview\Photoshop',
    'OC\Preview\TIFF',
  ],

  'trashbin_retention_obligation' => 'auto, 30',
  'activity_expire_days' => 90,

  'simpleSignUpLink.shown' => false,
  'knowledgebaseenabled' => false,
];
