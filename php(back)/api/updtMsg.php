<?php

require_once('core/core.php');
require_once('core/log.php');

class udp {

    private $bd;
    private $data;

        function __construct($base)
        {
            $this->bd = $base;
            if(file_get_contents("php://input")) {
                $this->data = json_decode(file_get_contents("php://input") , TRUE , JSON_UNESCAPED_UNICODE);
            } else {
                $this->data = $_GET;
            }
            
        }

        public function check() {
            if($this->data) {
                if($this->updMsg()) {
                    echo json_encode( array( 'status' => true));
                    exit();
                }
            }
                echo json_encode(array('status' => 'no data'));
                exit();
        }

        private function updMsg() {
            $stmt = $this->bd->prepare('UPDATE `msg` SET `type`= :type ,`addType`= :addType , `pri`= :pri WHERE `ts` = :ts');
            $stmt->execute( array( 'type' => $this->data['type'] , 'addType' => $this->data['addType'] , 'pri' => $this->data['pri'] , 'ts' => $this->data['ts'] ) );
        }

}

$res = new udp($conn);

$res->check();

?>