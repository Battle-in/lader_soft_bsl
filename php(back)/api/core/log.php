<?php

class loger {

    static function setLog($log , $type) {
       if(file_put_contents('../log/log.txt' , $type. ' : ' .print_r($log , 1) . '/n', FILE_APPEND)) {
           return true;
       } 
            return false;
    }

}



?>