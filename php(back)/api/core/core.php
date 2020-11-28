<?php
class Bd {
    protected static $datasourse = "mysql:host=localhost;dbname=u1145099_mailhelp";
    protected static $login = "u1145099_default";
    protected static $pass = "Z!Hq2ukD";
    protected static $base;
    protected static $opt = [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
    ];
    
    function __construct () {}

    private static function crateBd() {
        if(!isset(self::$base)) {
            try {
                self::$base = new PDO(self::$datasourse , self::$login , self::$pass , self::$opt);
            }
            catch (PDOExceptin $e) {
                echo $error=$e->getMessage();
                exit();
            }
            return self::$base;
        }
    }
    public static function getBd() {
        return self::crateBd();
    }
}

$conn = Bd::getBd();


?>