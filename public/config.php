<?php
// config.php

class Config
{
    private static $conn = null;

    public static function getConn() {
        if (self::$conn === null) {
            $host   = '100.104.103.66';
            $dbname = 'brasileirao';
            $user   = 'goat';
            $pass   = 'Refacty_db5498!#';

            try {
                self::$conn = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
                self::$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            } catch (PDOException $e) {
                die("Erro na conexão: " . $e->getMessage());
            }
        }
        return self::$conn;
    }
}
