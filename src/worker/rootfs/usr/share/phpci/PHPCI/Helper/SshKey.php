<?php

namespace PHPCI\Helper;

class SshKey
{
    /**
     * @return array
     */
    public function generate()
    {
        return array(
            'private_key' => file_get_contents('/home/www-data/.ssh/id_rsa'),
            'public_key' => file_get_contents('/home/www-data/.ssh/id_rsa.pub'),
        );
    }
}
