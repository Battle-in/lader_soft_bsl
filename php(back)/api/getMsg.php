<?php
require_once('core/core.php');


class msg {

    private $req;
    private $to;
    private $cat;
    private $addCat;
    private $pr;
    private $bd;
        function __construct($base) {
            $this->req = $_GET['req'];
            $this->to = $_GET['login'];
            $this->cat = $_GET['cat'];
            $this->addCat = $_GET['addCat'];
            $this->pr = $_GET['pr'];
            $this->bd = $base;
        }

        public function getMsg() {
  
            switch ($this->req) {
                case 'all':
                        $prop = [];
                    $stmt = $this->bd->query(" SELECT * FROM `msg` WHERE `ts` = '$this->to' ");
                    while ($row = $stmt->fetch(PDO::FETCH_LAZY))
                    {
                        $prop[] = [
                            'id' => $row['id'] ,
                            'title' => $row['title'] , 
                            'text' => $row['text'] ,
                            'type' => $row['type'] ,
                            'addType' => $row['addType'] ,
                            'date' => $row['date'] ,
                            'frms' => $row['froms'] ,
                            'ts' => $row['tos'] ,
                            'pri' => $row['pri'] 
                        ];
                    }
                    echo json_encode($prop , JSON_UNESCAPED_UNICODE);
                break; 
                
                case 'cat':
                        $prop = [];
                    $stmt = $this->bd->query(" SELECT * FROM `msg` WHERE `ts` = '$this->to' AND `type` = '$this->cat' ");
                    while ($row = $stmt->fetch(PDO::FETCH_LAZY))
                    {
                        $prop[] = [
                            'id' => $row['id'] ,
                            'title' => $row['title'] , 
                            'text' => $row['text'] ,
                            'type' => $row['type'] ,
                            'addType' => $row['addType'] ,
                            'date' => $row['date'] ,
                            'frms' => $row['froms'] ,
                            'ts' => $row['tos'] ,
                            'pri' => $row['pri'] 
                        ];
                    }
                    echo json_encode($prop , JSON_UNESCAPED_UNICODE);
                break;

                case 'prAll':
                        $prop = [];
                    $stmt = $this->bd->query(" SELECT * FROM `msg` WHERE `ts`= '$this->to' ORDER BY `msg`.`pri` DESC");
                    while ($row = $stmt->fetch(PDO::FETCH_LAZY))
                    {
                        $prop[] = [
                            'id' => $row['id'] ,
                            'title' => $row['title'] , 
                            'text' => $row['text'] ,
                            'type' => $row['type'] ,
                            'addType' => $row['addType'] ,
                            'date' => $row['date'] ,
                            'frms' => $row['froms'] ,
                            'ts' => $row['tos'] ,
                            'pri' => $row['pri'] 
                        ];
                    }
                    echo json_encode($prop , JSON_UNESCAPED_UNICODE);
                break;
    
                case 'pr':
                    $prop = [];
                $stmt = $this->bd->query(" SELECT * FROM `msg` WHERE `ts`= '$this->to' AND `type` = '$this->cat' ORDER BY `msg`.`pri` DESC");
                while ($row = $stmt->fetch(PDO::FETCH_LAZY))
                {
                    $prop[] = [
                        'id' => $row['id'] ,
                        'title' => $row['title'] , 
                        'text' => $row['text'] ,
                        'type' => $row['type'] ,
                        'addType' => $row['addType'] ,
                        'date' => $row['date'] ,
                        'frms' => $row['froms'] ,
                        'ts' => $row['tos'] ,
                        'pri' => $row['pri'] 
                    ];
                }
                echo json_encode($prop , JSON_UNESCAPED_UNICODE);
                break;
                case 'allDesc':
                    $prop = [];
                    $stmt = $this->bd->query(" SELECT * FROM `msg` WHERE `ts`= '$this->to' ORDER BY `msg`.`date` DESC");
                    while ($row = $stmt->fetch(PDO::FETCH_LAZY))
                    {
                        $prop[] = [
                            'id' => $row['id'] ,
                            'title' => $row['title'] , 
                            'text' => $row['text'] ,
                            'type' => $row['type'] ,
                            'addType' => $row['addType'] ,
                            'date' => $row['date'] ,
                            'frms' => $row['froms'] ,
                            'ts' => $row['tos'] ,
                            'pri' => $row['pri'] 
                        ];
                    }
                    echo json_encode($prop , JSON_UNESCAPED_UNICODE);
                break;

                case 'allAsc':
                    $prop = [];
                    $stmt = $this->bd->query(" SELECT * FROM `msg` WHERE `ts`= '$this->to' ORDER BY `msg`.`date` ASC");
                    while ($row = $stmt->fetch(PDO::FETCH_LAZY))
                    {
                        $prop[] = [
                            'id' => $row['id'] ,
                            'title' => $row['title'] , 
                            'text' => $row['text'] ,
                            'type' => $row['type'] ,
                            'addType' => $row['addType'] ,
                            'date' => $row['date'] ,
                            'frms' => $row['froms'] ,
                            'ts' => $row['tos'] ,
                            'pri' => $row['pri'] 
                        ];
                    }
                    echo json_encode($prop , JSON_UNESCAPED_UNICODE);
                break;
            }
        }


}

$res = new msg($conn);

$res->getMsg();



//http://mail-helpler/api/getMsg.php?req=allAsc&login=admin
//http://mail-helpler/api/getMsg.php?req=allDesc&login=admin
//http://mail-helpler/api/getMsg.php?req=prAll&login=admin&cat=spam&cat=spam - вывести все по приоритету без категории 
//http://mail-helpler/api/getMsg.php?req=pr&login=admin&cat=spam&cat=spam - вывести все по приоритету c конекретной категории указания конкретной категории
//http://mail-helpler/api/getMsg.php?req=cat&login=admin&cat=spam&cat=spam - выести по определнной категории  
//http://mail-helpler/api/getMsg.php?req=all&login=admin - вывести все без сортировки







?>