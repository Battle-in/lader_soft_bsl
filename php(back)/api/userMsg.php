<?php
require_once('core/core.php');

class usMg {

    private $bd;
    private $data;

        function __construct($base) 
        {
            $this->bd = $base;
            $this->data = $_GET;
        }

    public function getData() {
        $stmt = $this->bd->prepare('SELECT DISTINCT `login` , `text` , `avatar` , `date` , `type` , `ts` FROM `users` JOIN `msg` on users.login = msg.frms WHERE `type` = :type AND `ts` = :ts GROUP BY `login` ORDER BY `msg`.`date` DESC ');
        $stmt->execute( array('type' => $this->data['type'] , 'ts' => $this->data['ts']) );
        $prop = [];
        while($row = $stmt->fetch(PDO::FETCH_LAZY)) {
            $stmt2 = $this->bd->prepare('SELECT COUNT(`isCheck`) FROM `msg` WHERE `ts` = :ts AND `frms` = :frms AND `isCheck` = "no" ');
            $stmt2->execute( array( 'ts' => $this->data['ts'] , 'frms' => $row['login'] ) );
            $cnt = $stmt2->fetchColumn(0);
            $prop[] = [
                'frms' => $row['login'] ,
                'ts' => $row['ts'] ,
                'text' => $row['text'] , 
                'avatar' => $row['avatar'] ,
                'type' => $row['type'],
                'cntChek' => $cnt
            ];
        }
            echo json_encode($prop , JSON_UNESCAPED_UNICODE);
    }

}

$res = new usMg($conn);

$res->getData();


?>
