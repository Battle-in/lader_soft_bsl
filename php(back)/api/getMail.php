<?php

require_once('core/core.php');

file_put_contents('data.txt' , file_get_contents("php://input") , FILE_APPEND);

class mal {

    private $data;
    private $bd;
        function __construct($base)
        {   
            $this->bd = $base;
            $this->data = json_decode(file_get_contents("php://input") , TRUE , JSON_UNESCAPED_UNICODE);
        }

    public function msgMeng() {
        if(isset($this->data)) {
            if($this->checkMsg()) {
                $this->setMsg();
            }
                echo json_encode(array('status' => false));
                exit();
        } else {
            return json_encode(array('error' => 'not data or reapet msg'));
            exit();
        }
    }

    private function setMsg() {
        $stmt = $this->bd->prepare('INSERT INTO `msg` (`title`, `text`, `date`, `frms`, `ts` , `isCheck`) VALUES ( :title , :text , :date , :forms , :tos , :chek)');
        $stmt->execute(array( 'title' => $this->data['title'] , 'text' => $this->data['text'] , 'forms' => $this->data['from'] , 'tos' => $this->data['to'] , 'date' => date("Y-m-d H:i:s") , 'chek' => 'no' ));
            echo json_encode(array('status' => true));
            exit();
    }

    private function checkMsg() {
        
        $stmt = $this->bd->prepare('SELECT `title`, `text` FROM `msg` WHERE `title` = :title AND `text` = :text');
        $stmt->execute(array( 'title' => $this->data['title'] , 'text' => $this->data['text']));
        if(!$stmt->fetch(PDO::FETCH_LAZY)) {
            return true;
        }
            return false;
    }
}

$res = new mal($conn);
$res->msgMeng();
?>

