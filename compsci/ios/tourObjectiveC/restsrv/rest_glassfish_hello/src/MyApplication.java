/**
 * Created by zimine on 10/29/17.
 */

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;


//Defines the base URI for all resource URIs.
@ApplicationPath("/")
public class MyApplication extends Application {

    //The method returns a non-empty collection with classes,
    // that must be included in the published JAX-RS application
    @Override
    public Set<Class<?>> getClasses() {
        HashSet h = new HashSet<Class<?>>();
        h.add( Hello.class );
        h.add( HelloJ.class);
        return h;
    }

}
