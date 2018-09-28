These two programs are the demos for the connections and connection pool modules.

The data access that they run is just selecting some values against the dual psuedotable, so they
should run against any Oracle database without you having to create any tables of objects on
the target database.

You will need to go into the app.config files and update the connection string with the proper
values for the server name, oracle service name, oracle username and password.  All of the
fields are marked with a double hash character (##) to make what you need to update easier to
find.

This code was written in Visual Studio 2012.

This code uses the Oracle Managed Driver, so you should not need to edit TNS names or even have
an Oracle client installed.  The Managed Driver DLL is present in each solution, so there should
be nothing that you need to install.