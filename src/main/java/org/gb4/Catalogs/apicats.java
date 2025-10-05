package org.gb4.Catalogs;

import java.util.List;


import org.gb4.Catalogs.entities.CatalogosAll;
import org.gb4.Catalogs.repositories.repocats;

import io.smallrye.mutiny.Uni;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/hell")
@Produces(MediaType.APPLICATION_JSON)
public class apicats {
   @Inject
   repocats cat;
    @GET
    @Path("Cats-Elements-Lista") 
    public Uni<List<CatalogosAll>>  hello() {

//return cat.find(
  //  "SELECT DISTINCT c FROM Catalog c JOIN c.elements e WHERE c.name = ?1 AND e.id = ?2",
    //"Mirrortarjta",
    //678L).list();  "name": "Mirror2",

//return cat.find("SELECT DISTINCT c FROM CatalogosAll c JOIN c.elements e WHERE c.ids = ?1 and e.id=?2",4L,678l).list();

//return  cat.find("select c from CatalogosAll c join fetch c.elements e where c.id = ?1 and e.name = ?2",678L, "Mirror2").list();

return  cat.find("select c from CatalogosAll c join fetch c.elements e where c.ids = ?1 and e.name = ?2", 4L,"Mirror2").list();



    }
}
