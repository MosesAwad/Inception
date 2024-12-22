<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'db1' );

/** MySQL database username */
define( 'DB_USER', 'user' );

/** MySQL database password */
define( 'DB_PASSWORD', 'pswd' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define( 'WP_ALLOW_REPAIR', true );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'HU-3OMHo_O5/gN$R5#R_/=e-E2-T&x%#*lZC-UN$jt#-E 9<X7{[u59dg;J8X{}<');
define('SECURE_AUTH_KEY',  '}j@Zeb?Txh^ 1x`QIv/DH|remRi[]TO_59w(1l.NKy+qUl3}fs3ec7#)xfRD8*-Z');
define('LOGGED_IN_KEY',    'K9|_2_|ehlMpp9]Y=GF-gv4-oEC/$$-QqEIH)S8RvY.|2+sQ<KX2xY})Z||Tgr_c');
define('NONCE_KEY',        '0r-TlG.2zo& Q ote^ed|&lAsFy^l&3<+-ar(e?+AQd-gzEC6vL7jPRXGx*>SOQ#');
define('AUTH_SALT',        ')Sdf-%v[DCxl?vW)K4S5Ml^4H8BfhM;uNN^l>:[-bm6-}/Qz`L_xGG-YN7#Z&nj|');
define('SECURE_AUTH_SALT', '(Xw[|IFW;)brAi d&g%~_+{djDp2Ib R5P^]B=q@bJeH+y86m*L*Cer)[d2CR#- ');
define('LOGGED_IN_SALT',   'q7A,+>RoBdr-RxwH1xzfw5%MV~3UCeIvy5{+11`lTMn0ewYIFmsnkpRt5Tb-=uL}');
define('NONCE_SALT',       '=IjuT-v9W<0[ hdQiWnzm/SoaJv#/!wa+OPSu$`*K!_hNKXZC-UHAn4h$g&|]O[}');

define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );     


define('WP_CACHE', true);

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
?>