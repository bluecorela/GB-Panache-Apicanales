package org.gb4.Catalogos;

import java.util.List;

import org.gb4.Catalogos.entities.Catalog;
import org.gb4.Catalogos.repositories.RepositoriGen;

import io.smallrye.mutiny.Uni;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/hello")
@Produces(MediaType.APPLICATION_JSON)
public class apican {
   @Inject
   RepositoriGen cat;
    @GET
    @Path("Cat-Elements-List")
    public Uni<List<Catalog>>  hello() {


      return cat.findAll().list();
        
    }
}
