#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
my $nombre = $q->param("nombre");
my $texto = $q->param("texto");

my $user = "alumno";
my $password = "pweb1";
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.11";
my $dbh = DBI->connect($dsn, $user, $password) or die("no se pudo conectar");;
my $sth = $dbh->prepare("DELETE FROM MarkDown WHERE nombre=?");
$sth->execute("$nombre");
$sth = $dbh->prepare("INSERT INTO MarkDown(nombre, texto, hiperenlace, detele, edit) VALUES (?,?,?,?,?)");
$sth->execute("$nombre","$texto","<a href='view.pl?nombre=$nombre&texto=$texto'>$nombre</a>","<a href='detele.pl?nombre=$nombre&texto=$texto'>D</a>","<a href='edit.pl?nombre=$nombre&texto=$texto'>E</a>");
$sth->finish;
$dbh->disconnect;
print $q->header("text/html");
print<<BLOCK;
<!DOCTYPE html>
  <html>
    <head>
      <title>Hello FORM</title>
    </head>
    <body>
      <h1>$nombre</h1>
      <p>$texto</p>
      <h2>Página Grabada</h2><a href="list.pl?nombre=$nombre&texto=$texto">Listado de Paginas</a> 
    </body>
  </html>
BLOCK
