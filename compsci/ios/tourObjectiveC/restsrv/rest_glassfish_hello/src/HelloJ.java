
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;


@Path("/hellojson")
public class HelloJ {

    @GET
    //this method will produced the MIME media type  application/json"
    @Produces("application/json")
    public  String getClichedMessage(){
        String res = "{\"title\":\"Welcome to TekPubb\"," +
                      "\"db\":[{\"id\": 1," +
                                 "\"first_name\": \"Jeanette\"," +
                                 " \"last_name\": \"Penddreth\"," +
                                 " \"email\": \"jpenddreth0@census.gov\"," +
                                 " \"gender\": \"Female\"," +
                                 " \"ip_address\": \"26.58.193.2\"}," +
                              "{\"id\": 2," +
                                  "\"first_name\": \"Giavani\"," +
                                 " \"last_name\": \"Frediani\"," +
                                 " \"email\": \"gfrediani1@senate.gov\"," +
                                 " \"gender\": \"Male\"," +
                                 "\"ip_address\": \"229.179.4.212\"}," +
                              "{\"id\": 3," +
                                "\"first_name\": \"Peter\"," +
                               " \"last_name\": \"Carr\"," +
                               " \"email\": \"carr@gmail.com\"," +
                               " \"gender\": \"Male\"," +
                               "\"ip_address\": \"129.0.0.1\"}" +
                             "]" +
                     "}";
        return res;
    }
}

