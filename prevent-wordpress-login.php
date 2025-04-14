<?php

declare(strict_types=1);

/*
Plugin Name: Prevent WordPress Login
Description: Block access to the WordPress login route.
Version: 0.1.0
Author: Klein College of Media and Communication <kleinweb@temple.edu>
License: GPL-3.0-or-later
Text Domain: prevent-wordpress-login
*/

add_action('init', 'kleinweb_prevent_wordpress_login');

function kleinweb_prevent_wordpress_login()
{
    global $pagenow;
    $action = $_GET['action'] ?? '';
    if ($pagenow === 'wp-login.php' && (! $action || ($action && ! in_array($action, ['logout', 'lostpassword', 'rp', 'resetpass'])))) {
        $page = get_bloginfo('url');
        wp_redirect($page);
        exit;
    }
}
