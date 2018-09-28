/**
 * Created by zimine on 10/29/17.
 */

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;


@Path("/helloworld")
public class Hello {

    @GET
    //this method will produced the MIME media type "text/plain"
    @Produces("text/plain")
    public  String getClichedMessage(){
        return "Hello World";
    }
}
