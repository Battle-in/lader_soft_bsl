<?php
require_once('core/core.php');
//require('core/log.php');


class user {
    private $bd;
    private $login;
    private $pass;
    private $deviceID;

        function __construct($bd) {
            $this->bd = $bd;
            $this->login = $_GET['login'];
            $this->pass = $_GET['pass'];
            $this->deviceID = $_GET['devID'];
        }

        private function checkUser() {
            if(isset($this->login) && isset($this->pass)) {
                $stmt = $this->bd->prepare('SELECT `id`, `device_id`, `login`, `pass` FROM `users` WHERE `login` = ? AND `pass` = ? ');
                $stmt->execute(array($this->login , $this->pass));

                    while ($row = $stmt->fetch(PDO::FETCH_LAZY))
                    {
                        $login = $row[2];
                        $pass = $row[3];
                    }
                if($login == $this->login && $pass == $this->pass) {
                    return array('status' => true , 'login' => $login );
                } 
                    return array('status' => false); 
            } 
                return array('status' => false);
        }

        public function getProp() {
            echo json_encode( $this->checkUser() );
        }
 
        
}


$res = new user($conn);
$res->getProp();



?>