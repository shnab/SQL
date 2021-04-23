
ALTER LISTENER=
 (DESCRIPTION=
  (ADDRESS=(PROTOCOL=tcp)(HOST=sales-server)(PORT=1521)(QUEUESIZE=20)));


alter system set service_name='orcl';
alter system register;

XE =
   (DESCRIPTION =
     (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521) (service_name= 'orcl')
     (CONNECT_DATA =
       (SERVER = DEDICATED)
       (SERVICE_NAME = ORCL)
     )
   )
   
   alter system set local_listener"(description = (address = (protocol = tcp) (host = localhost) (port = 1521)) (connect_data = (server = dedicated) (service_name = orcl);