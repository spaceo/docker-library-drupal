<?php

// Load a drushrc.php file from the 'drush' folder at the root of the current
// git repository. Customize as desired.
// (Script by grayside; @see: http://grayside.org/node/93)
$repo_dir = drush_get_option('root') ? drush_get_option('root') : getcwd();
$success = drush_shell_exec('cd %s && git rev-parse --show-toplevel 2> ' . drush_bit_bucket(), $repo_dir);
if ($success) {
  $output = drush_shell_exec_output();
  $repo = $output[0];
// If drush directory is not found, look for a parent git repo which might contain the drush folder
  if (!is_dir($repo . '/drush')) {
    $success = drush_shell_exec('cd %s && cd .. && git rev-parse --show-toplevel 2> ' . drush_bit_bucket(), $repo);
    if ($success) {
      $output = drush_shell_exec_output();
      $repo = $output[0];
      if (!is_dir($repo . '/drush')) {
        $success = drush_shell_exec('cd %s && cd .. && git rev-parse --show-toplevel 2> ' . drush_bit_bucket(), $repo);
        if ($success) {
          $output = drush_shell_exec_output();
          $repo = $output[0];
        }
      }
    }
  }
  if (is_dir($repo . '/drush')) {
    $options['config'] = $repo . '/drush/drushrc.php';
    $options['include'] = $repo . '/drush/commands';
    $options['alias-path'] = $repo . '/drush/aliases';
//print_r($options); // can be used to debug which directories it finds.
  }
}