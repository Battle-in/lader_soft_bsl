<?php
require_once('core/core.php');

class msgOnUser {
    
    private $bd;
    private $data;

        function __construct($base)
        {
            $this->bd = $base;
            $this->data = $_GET;
        }

        public function getMsg() {
            $stmt = $this->bd->prepare('SELECT * FROM `msg` JOIN `users` on users.login = msg.frms WHERE `type` = :type AND `ts` = :ts AND `frms` = :frms ORDER BY `msg`.`date` DESC');
            $stmt->execute( array('type' => $this->data['type'] , 'ts' => $this->data['ts']  , 'frms' => $this->data['frms']) );
            $prop = [];
            while($row = $stmt->fetch(PDO::FETCH_LAZY)) {
                $prop[] = [
                    'frms' => $row['login'] ,
                    'ts' => $row['ts'] ,
                    'text' => $row['text'] ,
                    'title' => $row['title'] ,
                    'pri' => $row['pri'] , 
                    'type' => $row['type'],
                    'date' => $row['date'] ,
                    'isCheck' => $row['isCheck'] ,
                ];
            }
                
                echo json_encode($prop , JSON_UNESCAPED_UNICODE);
        }

        private function isChek() {
            $stmt = $this->bd->prepare('');
            $stmt->execute();
        }

}

//SELECT * FROM `msg` JOIN `users` on users.login = msg.frms WHERE `type` = 'spam' AND `ts` = 'andrei' ORDER BY `msg`.`date` DESC

$res = new msgOnUser($conn);

$res->getMsg();

?>