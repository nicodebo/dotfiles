<?php

try 
{
  $pdo = new PDO('mysql:host={{cookiecutter.host}}:{{cookiecutter.mysqlport}};dbname={{cookiecutter.db_name}}', "{{cookiecutter.db_user}}", "{{cookiecutter.db_pwd}}", array(
      PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8",
      PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // permet de recupérer des tableaux
      PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING // permet d'afficher les erreurs
    ));
}
catch (PDOException $e) 
{
  echo 'Erreur de connexion : ' . $e->getMessage();
}
