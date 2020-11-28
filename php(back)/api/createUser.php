<?php
require_once('core/core.php');

class user {
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
        $stmt = $this->bd->prepare('SELECT `login` FROM `users` WHERE  `login` = ?');
        $stmt->execute(array($this->login));
        $login = $stmt->fetchColumn(0);
        if($login != $this->login && isset($this->pass) && isset($this->deviceID)) {
            $stmt = $this->bd->prepare('INSERT INTO `users`( `device_id`, `login`, `pass`) VALUES (:id , :lo , :pa)');
            $stmt->execute(array('id' => $this->deviceID , 'lo' => $this->login ,'pa' => $this->pass ));
                return array('status' => true , 'login' => $this->login);
        }
            return array('status' => false); 
    }

    public function getData() {
       echo json_encode( $this->checkUser() );
    }

}

$res = new user($conn);

$res-> getData();

//SELECT `id`, `title`, `text`, `type`, `addType`, `date`, `froms`, `tos`, `pri` FROM `msg` WHERE `tos` = 'admin' AND `type` = 'spam' 


?>