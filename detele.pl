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
$sth->finish;
$dbh->disconnect;
print $q->header("text/html");
print<<BLOCK;
<!DOCTYPE html>
  <html lang="es">
    <head>
      <title>Hello FORM</title>
      <meta charset="UTF-8">
    </head>
    <body>
      <h1>La pagina ha sido eliminada</h1>
      <h2>Página Grabada</h2><a href="list.pl?nombre=$nombre&texto=$texto">Listado de Paginas</a> 
    </body>
  </html>
BLOCK

