<?php

/**
 * Resend SMTP + reply-to configuration for Skafld Cloud.
 * SMTP host/port/auth are set via Railway env vars (SMTP_HOST, etc).
 * This file adds reply-to which the Docker env vars don't support.
 */
$CONFIG = [
  'mail_smtpreplytoaddress' => 'hello@skafldstudio.com',
  'mail_send_plaintext_only' => false,
];
