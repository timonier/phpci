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
            'private_key' => file_get_contents('/var/www/.ssh/id_rsa'),
            'public_key' => file_get_contents('/var/www/.ssh/id_rsa.pub'),
        );
    }
}
